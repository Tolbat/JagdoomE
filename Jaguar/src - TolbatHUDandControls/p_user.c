/* P_user.c */

#include "doomdef.h"
#include "p_local.h"
#include "st_main.h"


fixed_t 		forwardmove[2] = {0x38000, 0x60000}; 
fixed_t 		sidemove[2] = {0x38000, 0x58000}; 

#define SLOWTURNTICS    10
fixed_t			angleturn[] =
	{300,300,500,500,600,700,800,900,900,1000};
fixed_t			fastangleturn[] =
	{800,800,900,1000,1000,1200,1200,1300,1300,1400};
	

/*============================================================================= */

mobj_t		*slidething;
extern	fixed_t		slidex, slidey;
extern	line_t	*specialline;

void P_SlideMove ();


void P_PlayerMove (mobj_t *mo)
{
	fixed_t		momx, momy;
	line_t		*latchedline;
	fixed_t		latchedx, latchedy;
		
	momx = vblsinframe*(mo->momx>>2);
	momy = vblsinframe*(mo->momy>>2);
	
	slidething = mo;
	
#ifdef JAGUAR
{
	extern	int p_slide_start;
	DSPFunction (&p_slide_start);
}
#else
	P_SlideMove ();
#endif
		
	latchedline = (line_t *)DSPRead (&specialline);
	latchedx = DSPRead (&slidex);
	latchedy = DSPRead (&slidey);
	
	if (latchedx == mo->x && latchedy == mo->y)
		goto stairstep;
		
	if ( P_TryMove (mo, latchedx, latchedy) )
		goto dospecial;
		
stairstep:
	if (momx > MAXMOVE)
		momx = MAXMOVE;
	if (momx < -MAXMOVE)
		momx = -MAXMOVE;
	if (momy > MAXMOVE)
		momy = MAXMOVE;
	if (momy < -MAXMOVE)
		momy = -MAXMOVE;
		
/* something fucked up in slidemove, so stairstep */

	if (P_TryMove (mo, mo->x, mo->y + momy))
	{
		mo->momx = 0;
		mo->momy = momy;
		goto dospecial;
	}
	
	if (P_TryMove (mo, mo->x + momx, mo->y))
	{
		mo->momx = momx;
		mo->momy = 0;
		goto dospecial;
	}

	mo->momx = mo->momy = 0;

dospecial:
	if (latchedline)
		P_CrossSpecialLine (latchedline, mo);
}


/* 
=================== 
= 
= P_PlayerXYMovement  
=
=================== 
*/ 

#define	STOPSPEED		0x1000
#define	FRICTION		0xd240

void P_PlayerXYMovement (mobj_t *mo) 
{ 	
	P_PlayerMove (mo);

/* */
/* slow down */
/* */
	if (mo->z > mo->floorz)
		return;		/* no friction when airborne */

	if (mo->flags & MF_CORPSE)
		if (mo->floorz != mo->subsector->sector->floorheight)
			return;			/* don't stop halfway off a step */

	if (mo->momx > -STOPSPEED && mo->momx < STOPSPEED
	&& mo->momy > -STOPSPEED && mo->momy < STOPSPEED)
	{	
		mo->momx = 0;
		mo->momy = 0;
	}
	else
	{
		mo->momx = (mo->momx>>8)*(FRICTION>>8);
		mo->momy = (mo->momy>>8)*(FRICTION>>8);
	}
}


/*
===============
=
= P_PlayerZMovement
=
===============
*/

void P_PlayerZMovement (mobj_t *mo)
{	
/* */
/* check for smooth step up */
/* */
	if (mo->z < mo->floorz)
	{
		mo->player->viewheight -= mo->floorz-mo->z;
		mo->player->deltaviewheight = (VIEWHEIGHT - mo->player->viewheight)>>2;
	}

/* */
/* adjust height */
/* */
	mo->z += mo->momz;
	
/* */
/* clip movement */
/* */
	if (mo->z <= mo->floorz)
	{	/* hit the floor */
		if (mo->momz < 0)
		{
			if (mo->momz < -GRAVITY*4)	/* squat down */
			{
				mo->player->deltaviewheight = mo->momz>>3;
				S_StartSound (mo, sfx_oof);
			}
			mo->momz = 0;
		}
		mo->z = mo->floorz;
	}
	else
	{
		if (mo->momz == 0)
			mo->momz = -GRAVITY*2;
		else
			mo->momz -= GRAVITY;
	}
	
	if (mo->z + mo->height > mo->ceilingz)
	{	/* hit the ceiling */
		if (mo->momz > 0)
			mo->momz = 0;
		mo->z = mo->ceilingz - mo->height;		
	}
	
} 
 

/*
================
=
= P_PlayerMobjThink
=
================
*/

void P_PlayerMobjThink (mobj_t *mobj)
{
	state_t	*st;
	int		state;
	
/* */
/* momentum movement */
/* */
	if (mobj->momx || mobj->momy)
		P_PlayerXYMovement (mobj);

	if ( (mobj->z != mobj->floorz) || mobj->momz)
		P_PlayerZMovement (mobj);
	
/* */
/* cycle through states, calling action functions at transitions */
/* */
	if (mobj->tics == -1)
		return;				/* never cycle */
		
	mobj->tics--;
	
	if (mobj->tics > 0)
		return;				/* not time to cycle yet */
		
	state = mobj->state->nextstate;	
	st = &states[state];

	mobj->state = st;
	mobj->tics = st->tics;
	mobj->sprite = st->sprite;
	mobj->frame = st->frame;
}

/*============================================================================= */


/*
====================
= 
= P_BuildMove 
= 
==================== 
*/

void P_BuildMove (player_t *player) 
{ 
    boolean strafe; 
    int speed; 
    int buttons, oldbuttons; 
    mobj_t *mo; 

    buttons = ticbuttons[playernum];
    oldbuttons = oldticbuttons[playernum];
    
    strafe = (buttons & BT_STRAFE) || (buttons & JP_4) || (buttons & JP_6) > 0; 
    speed = (buttons & BT_SPEED) > 0;

/*  */
/* use two stage accelerative turning on the joypad  */
/*  */
	if ( (buttons & BT_LEFT) && (oldbuttons & BT_LEFT) )
		player->turnheld++; 
	else
	if ( (buttons & BT_RIGHT) && (oldbuttons & BT_RIGHT) )
		player->turnheld++; 
	else 
		player->turnheld = 0; 
	if (player->turnheld >= SLOWTURNTICS)
		player->turnheld = SLOWTURNTICS-1;
 
	player->forwardmove = player->sidemove = player->angleturn = 0;
	
	if (strafe) 
	{ 
        if (buttons & BT_STRAFE)
        {
            if (buttons & BT_RIGHT) 
                player->sidemove = sidemove[speed]; 
            if (buttons & BT_LEFT) 
                player->sidemove = -sidemove[speed]; 
        }
        else
        {
            if (buttons & JP_6) 
                player->sidemove = sidemove[speed]; 
            if (buttons & JP_4) 
                player->sidemove = -sidemove[speed]; 
            if (speed && !(buttons&(BT_UP|BT_DOWN)) )
            {
                if (buttons & BT_RIGHT) 
                    player->angleturn = -((fastangleturn[player->turnheld]
                    *vblsinframe)<<15); 
                if (buttons & BT_LEFT) 
                    player->angleturn = (fastangleturn[player->turnheld]
                    *vblsinframe)<<15; 
            }
            else
            {
                if (buttons & BT_RIGHT) 
                    player->angleturn = -angleturn[player->turnheld]<<17; 
                if (buttons & BT_LEFT) 
                    player->angleturn = angleturn[player->turnheld]<<17; 
            }
        }
	} 
	else 
	{ 
		if (speed && !(buttons&(BT_UP|BT_DOWN)) )
		{
			if (buttons & BT_RIGHT) 
				player->angleturn = -((fastangleturn[player->turnheld]
				*vblsinframe)<<15); 
			if (buttons & BT_LEFT) 
				player->angleturn = (fastangleturn[player->turnheld]
				*vblsinframe)<<15; 
		}
		else
		{
			if (buttons & BT_RIGHT) 
				player->angleturn = -angleturn[player->turnheld]<<17; 
			if (buttons & BT_LEFT) 
				player->angleturn = angleturn[player->turnheld]<<17; 
		}

	} 
 
	if (buttons & (BT_UP|BT_2)) 
		player->forwardmove = forwardmove[speed]; 
	if (buttons & (BT_DOWN|BT_5)) 
		player->forwardmove = -forwardmove[speed];  		 
/* JP_8: Turn the player 180 degrees */
if ((buttons & JP_8) && !(oldbuttons & JP_8)) /* Trigger only on fresh press */
{
    player->angleturn += 0x80000000; /* Add 180 degrees */

}
else
{
    player->turnheld = 0; /* Reset turnheld when the button is released */
}



/* */
/* if slowed down to a stop, change to a standing frame */
/* */
	mo = player->mo;
	
	if (!mo->momx && !mo->momy
	&& player->forwardmove== 0 && player->sidemove == 0 )
	{	/* if in a walking frame, stop moving */
		if (mo->state == &states[S_PLAY_RUN1] 
		|| mo->state == &states[S_PLAY_RUN2]
		|| mo->state == &states[S_PLAY_RUN3]
		|| mo->state == &states[S_PLAY_RUN4])
			P_SetMobjState (mo, S_PLAY);
	}
	
} 

/*
===============================================================================

						movement

===============================================================================
*/

#define MAXBOB			0x100000		/* 16 pixels of bob */

boolean		onground;

/* 
================== 
= 
= P_Thrust 
= 
= moves the given origin along a given angle 
= 
================== 
*/ 
 
void P_Thrust (player_t *player, angle_t angle, fixed_t move) 
{
	angle >>= ANGLETOFINESHIFT;
	move >>= 16;
	player->mo->momx += move*finecosine[angle]; 
	player->mo->momy += move*finesine[angle];
}



/* 
================== 
= 
= P_CalcHeight 
= 
= Calculate the walking / running height adjustment
=
================== 
*/ 

void P_CalcHeight (player_t *player) 
{
	int			angle;
	fixed_t		bob;
	fixed_t		val;
	

/* */
/* regular movement bobbing (needs to be calculated for gun swing even */
/* if not on ground) */
/* OPTIMIZE: tablify angle  */
	val = player->mo->momx>>8;
	player->bob = val*val;
	val = player->mo->momy>>8;
	player->bob += val*val;

	player->bob >>= 4;
	if (player->bob>MAXBOB)
	{
		player->bob = MAXBOB;
	}

	if (!onground)
	{
		player->viewz = player->mo->z + VIEWHEIGHT;
		if (player->viewz > player->mo->ceilingz-4*FRACUNIT)
			player->viewz = player->mo->ceilingz-4*FRACUNIT;
		return;
	}
		
	angle = (FINEANGLES/40*gamevbls)&(FINEANGLES-1);
	bob = (( player->bob )>>17) * finesine[angle];
	
/* */
/* move viewheight */
/* */
	if (player->playerstate == PST_LIVE)
	{
		player->viewheight += player->deltaviewheight;
		if (player->viewheight > VIEWHEIGHT)
		{
			player->viewheight = VIEWHEIGHT;
			player->deltaviewheight = 0;
		}
		if (player->viewheight < VIEWHEIGHT/2)
		{
			player->viewheight = VIEWHEIGHT/2;
			if (player->deltaviewheight <= 0)
				player->deltaviewheight = 1;
		}
	
		if (player->deltaviewheight)	
		{
			player->deltaviewheight += FRACUNIT/2;
			if (!player->deltaviewheight)
				player->deltaviewheight = 1;
		}
	}
	player->viewz = player->mo->z + player->viewheight + bob;
	if (player->viewz > player->mo->ceilingz-4*FRACUNIT)
		player->viewz = player->mo->ceilingz-4*FRACUNIT;
}

/*
=================
=
= P_MovePlayer
=
=================
*/

void P_MovePlayer (player_t *player)
{	
	player->mo->angle += player->angleturn;

	/* don't let the player control movement if not onground */
	onground = (player->mo->z <= player->mo->floorz);
	
	if (player->forwardmove && onground)
		P_Thrust (player, player->mo->angle, player->forwardmove);
	if (player->sidemove && onground)
		P_Thrust (player, player->mo->angle-ANG90, player->sidemove);

	if ( (player->forwardmove || player->sidemove) 
	&& player->mo->state == &states[S_PLAY] )
		P_SetMobjState (player->mo, S_PLAY_RUN1);

}	


/*
=================
=
= P_DeathThink
=
=================
*/

#define		ANG5	(ANG90/18)

void P_DeathThink (player_t *player)
{
	angle_t		angle, delta;

	P_MovePsprites (player);
	
/* fall to the ground */
	if (player->viewheight > 8*FRACUNIT)
		player->viewheight -= FRACUNIT;
	onground = (player->mo->z <= player->mo->floorz);
	P_CalcHeight (player);
	
	if (player->attacker && player->attacker != player->mo)
	{
		angle = R_PointToAngle2 (player->mo->x, player->mo->y
		, player->attacker->x, player->attacker->y);
		delta = angle - player->mo->angle;
		if (delta < ANG5 || delta > (unsigned)-ANG5)
		{	/* looking at killer, so fade damage flash down */
			player->mo->angle = angle;
			if (player->damagecount)
				player->damagecount--;
		}
		else if (delta < ANG180)
			player->mo->angle += ANG5;
		else
			player->mo->angle -= ANG5;
	}
	else if (player->damagecount)
		player->damagecount--;
	

	if ( (ticbuttons[playernum] & BT_USE) && player->viewheight <= 8*FRACUNIT)
		player->playerstate = PST_REBORN;
}



/*
=================
=
= P_PlayerThink
=
=================
*/

extern int ticphase;

void P_PlayerThink(player_t *player)
{
    int buttons;
    /* Declare toggle variables at the top of the file */
static int toggle_weapon_1 = wp_pistol;    /* Toggle state for JP_1 */
static int toggle_weapon_3 = wp_shotgun;  /* Toggle state for JP_3 */
static int toggle_weapon_9 = wp_plasma;   /* Toggle state for JP_9 */
static int toggle_weapon_star = wp_pistol; /* Toggle state for JP_STAR (all weapons forward) */
static int toggle_weapon_num = wp_pistol; /* Toggle state for JP_NUM (all weapons backward) */

    buttons = ticbuttons[playernum];

    ticphase = 20;
    P_PlayerMobjThink(player->mo);

    ticphase = 21;
    P_BuildMove(player);

    /*
    = chain saw run forward
    */
    if (player->mo->flags & MF_JUSTATTACKED)
    {
        player->angleturn = 0;
        player->forwardmove = 0xc800;
        player->sidemove = 0;
        player->mo->flags &= ~MF_JUSTATTACKED;
    }

    if (player->playerstate == PST_DEAD)
    {
        P_DeathThink(player);
        return;
    }

    /*
    = move around
    */
    ticphase = 22;
    if (player->mo->reactiontime)
        player->mo->reactiontime--;
    else
        P_MovePlayer(player);
    P_CalcHeight(player);
    if (player->mo->subsector->sector->special)
        P_PlayerInSpecialSector(player);
/* */
/* check for weapon change */
/* */
ticphase = 23;
if (player->pendingweapon == wp_nochange)
{
    /* JP_1: Toggle between Pistol and Fist (or Chainsaw if owned) */
    if (buttons & JP_1)
    {
        if (player->weaponowned[wp_chainsaw])
        {
            /* Toggle between Pistol and Chainsaw */
            if (toggle_weapon_1 == wp_pistol)
            {
                toggle_weapon_1 = wp_chainsaw;
                player->pendingweapon = wp_chainsaw;
            }
            else
            {
                toggle_weapon_1 = wp_pistol;
                player->pendingweapon = wp_pistol;
            }
        }
        else
        {
            /* Toggle between Pistol and Fist */
            if (toggle_weapon_1 == wp_pistol && player->weaponowned[wp_fist])
            {
                toggle_weapon_1 = wp_fist;
                player->pendingweapon = wp_fist;
            }
            else
            {
                toggle_weapon_1 = wp_pistol;
                player->pendingweapon = wp_pistol;
            }
        }
    }

    /* JP_3: Toggle between Shotgun and Chaingun */
    if (buttons & JP_3)
    {
        if (player->weaponowned[wp_shotgun] && toggle_weapon_3 == wp_shotgun)
        {
            toggle_weapon_3 = wp_chaingun;
            if (player->weaponowned[wp_chaingun])
                player->pendingweapon = wp_chaingun;
            else
                player->pendingweapon = wp_pistol;
        }
        else if (player->weaponowned[wp_chaingun])
        {
            toggle_weapon_3 = wp_shotgun;
            player->pendingweapon = wp_shotgun;
        }
        else
        {
            player->pendingweapon = wp_pistol;
        }
    }

    /* JP_7: Directly assign Missile Launcher */
    if ((buttons & JP_7) && player->weaponowned[wp_missile])
    {
        player->pendingweapon = wp_missile;
    }

    /* JP_9: Toggle between Plasma and BFG with fallback */
    if (buttons & JP_9)
    {
        if (toggle_weapon_9 == wp_plasma && player->weaponowned[wp_bfg])
        {
            toggle_weapon_9 = wp_bfg;
            player->pendingweapon = wp_bfg;
        }
        else if (toggle_weapon_9 == wp_bfg && player->weaponowned[wp_plasma])
        {
            toggle_weapon_9 = wp_plasma;
            player->pendingweapon = wp_plasma;
        }
        else if (player->weaponowned[wp_missile])
        {
            player->pendingweapon = wp_missile;
        }
        else if (player->weaponowned[wp_chaingun])
        {
            player->pendingweapon = wp_chaingun;
        }
        else if (player->weaponowned[wp_shotgun])
        {
            player->pendingweapon = wp_shotgun;
        }
        else
        {
            player->pendingweapon = wp_pistol;
        }
    }

/* JP_STAR: Toggle backward through all weapons */
if (buttons & JP_STAR)
{
    int start_weapon = toggle_weapon_star; /* Store the starting point to prevent infinite loop */

    do
    {
        toggle_weapon_star--; /* Move backward */
        if (toggle_weapon_star < wp_fist) /* Wrap around to the last weapon */
            toggle_weapon_star = wp_bfg;

        /* Skip fist if chainsaw is owned */
        if (toggle_weapon_star == wp_fist && player->weaponowned[wp_chainsaw])
        {
            toggle_weapon_star = wp_chainsaw;
        }
    } while (!player->weaponowned[toggle_weapon_star] && toggle_weapon_star != start_weapon);

    /* Set pendingweapon only if the weapon is owned */
    if (player->weaponowned[toggle_weapon_star])
    {
        player->pendingweapon = toggle_weapon_star;
    }
}

/* JP_NUM: Toggle forward through all weapons */
if (buttons & JP_NUM)
{
    /* Synchronize toggle_weapon_num with the current readyweapon */
    toggle_weapon_num = player->readyweapon;

    if (toggle_weapon_num == wp_fist)
    {
        if (player->weaponowned[wp_chainsaw])
        {
            toggle_weapon_num = wp_chainsaw;
        }
        else if (player->weaponowned[wp_pistol])
        {
            toggle_weapon_num = wp_pistol;
        }
        else
        {
            toggle_weapon_num = wp_fist; /* Default to fist if no other weapons are owned */
        }
    }
    else if (toggle_weapon_num == wp_chainsaw)
    {
        if (player->weaponowned[wp_pistol])
        {
            toggle_weapon_num = wp_pistol;
        }
        else
        {
            toggle_weapon_num = wp_fist; /* Wrap back to fist */
        }
    }
    else if (toggle_weapon_num == wp_pistol)
    {
        if (player->weaponowned[wp_shotgun])
        {
            toggle_weapon_num = wp_shotgun;
        }
        else if (player->weaponowned[wp_chaingun])
        {
            toggle_weapon_num = wp_chaingun;
        }
        else
        {
            toggle_weapon_num = wp_fist; /* Wrap back to fist */
        }
    }
    else if (toggle_weapon_num == wp_shotgun)
    {
        if (player->weaponowned[wp_chaingun])
        {
            toggle_weapon_num = wp_chaingun;
        }
        else if (player->weaponowned[wp_missile])
        {
            toggle_weapon_num = wp_missile;
        }
        else
        {
            toggle_weapon_num = wp_fist; /* Wrap back to fist */
        }
    }
    else if (toggle_weapon_num == wp_chaingun)
    {
        if (player->weaponowned[wp_missile])
        {
            toggle_weapon_num = wp_missile;
        }
        else if (player->weaponowned[wp_plasma])
        {
            toggle_weapon_num = wp_plasma;
        }
        else
        {
            toggle_weapon_num = wp_fist; /* Wrap back to fist */
        }
    }
    else if (toggle_weapon_num == wp_missile)
    {
        if (player->weaponowned[wp_plasma])
        {
            toggle_weapon_num = wp_plasma;
        }
        else if (player->weaponowned[wp_bfg])
        {
            toggle_weapon_num = wp_bfg;
        }
        else
        {
            toggle_weapon_num = wp_fist; /* Wrap back to fist */
        }
    }
    else if (toggle_weapon_num == wp_plasma)
    {
        if (player->weaponowned[wp_bfg])
        {
            toggle_weapon_num = wp_bfg;
        }
        else
        {
            toggle_weapon_num = wp_fist; /* Wrap back to fist */
        }
    }
    else if (toggle_weapon_num == wp_bfg)
    {
        if (player->weaponowned[wp_fist])
        {
            toggle_weapon_num = wp_fist;
        }
        if (player->weaponowned[wp_chainsaw])
        {
            toggle_weapon_num = wp_chainsaw;
        }
    }

    /* Validate ownership before setting pendingweapon */
    if (player->weaponowned[toggle_weapon_num])
    {
        player->pendingweapon = toggle_weapon_num;
    }
}

/* Avoid unnecessary weapon change */
if (player->pendingweapon == player->readyweapon)
{
    player->pendingweapon = wp_nochange;
}


}

/* */
/* check for use */
/* */
	if (buttons & BT_USE)
	{
		if (!player->usedown)
		{
			P_UseLines (player);
			player->usedown = true;
		}
	}
	else
		player->usedown = false;

ticphase = 24;
	if (buttons & BT_ATTACK)
	{
		player->attackdown++;
		if (player->attackdown > 30 && playernum == consoleplayer &&
		(player->readyweapon == wp_chaingun || player->readyweapon == wp_plasma) )
			stbar.specialFace = f_mowdown;			
	}
	else
		player->attackdown = 0;
			
/* */
/* cycle psprites */
/* */
ticphase = 25;
	P_MovePsprites (player);
ticphase = 26;
	
	
/* */
/* counters */
/* */
	if (player->powers[pw_strength])
		player->powers[pw_strength]++;	/* strength counts up to diminish fade */
		
	if (player->powers[pw_invulnerability])
		player->powers[pw_invulnerability]--;
		
	if (player->powers[pw_ironfeet])
		player->powers[pw_ironfeet]--;
		
	if (player->damagecount)
		player->damagecount--;
		
	if (player->bonuscount)
		player->bonuscount--;
}


