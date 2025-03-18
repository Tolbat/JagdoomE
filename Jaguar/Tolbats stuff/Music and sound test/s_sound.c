/* s_sound.c */
#include "doomdef.h"
#include "music.h"

#define EXTERN_BUFFER_SIZE (EXTERNALQUADS*32/2)

sfxchannel_t	sfxchannels[SFXCHANNELS];

boolean			channelschanged;	/* set by S_StartSound to signal */
                                    /* update to remix speculative samples */

int				finalquad;			/* the last quad mixed by update. */
                                    
int 			sfxvolume = 128;	/* range 0 - 255 */
int 			musicvolume = 64;	/* range 0 - 255 */
int				oldsfxvolume = 128;	/* to detect transition to sound off */

int				soundtics;			/* time spent mixing sounds */
int				soundstarttics;		/* time S_Update started */

int				sfxsample;			/* the sample about to be output */
                                    /* by S_WriteOutSamples */

/*			 MUSIC VARIABLES */

sfx_t           *instruments[256];	/* pointers to all patches */

channel_t       music_channels[10];	/* master music channel list */

int             musictime;			/* internal music time, follows samplecount */
int             next_eventtime;		/* when next event will occur */
unsigned char   *music;				/* pointer to current music data */
unsigned char   *music_start;		/* current music start pointer */
unsigned char   *music_end;			/* current music end pointer */
unsigned char	*music_memory;		/* current location of cached music */

int             samples_per_midiclock;	/* multiplier for midi clocks */

int				musictics = 0;

#define abs(x) ((x)<0 ? -(x) : (x))

/*
==================
=
= S_Init
=
==================
*/

void S_Init(void)
{
    int		i,l;
    int	lump, end;
    int instnum;

/*				SFX */
    
    for (i=1 ; i < NUMSFX ; i++)
    {
        l = W_CheckNumForName(S_sfx[i].name);
        if (l != -1)
            S_sfx[i].md_data = W_POINTLUMPNUM(l);
    }	

/*				MUSIC */

     D_memset(instruments, 0, 256 * 4);
     lump = W_GetNumForName("inststrt");			/* get available instruments[] */
     end	= W_GetNumForName("instend");
     while (lump != end)
     {
         instnum = (lumpinfo[lump].name[1]-'0')*100
                 + (lumpinfo[lump].name[2]-'0')*10
                 + (lumpinfo[lump].name[3]-'0')
                 + (lumpinfo[lump].name[0] == 'P' ? 128 : 0);
         instruments[instnum] = (sfx_t *) (wadfileptr + lumpinfo[lump].filepos);
         lump++;
     }
 
     /* hack test */
    music_memory = 0;
    music = 0;
    D_memset(music_channels, 0, sizeof(music_channels));
    musictime = 0;
    next_eventtime = 0;
    /*	S_StartSong(1,1); */
}

/*
==================
=
= S_Clear
=
==================
*/

void S_Clear (void)
{
    D_memset (sfxchannels,0,sizeof(sfxchannels));
    D_memset (soundbuffer,0,0x4000);
}

void S_RestartSounds (void)
{
}

/*
==================
=
= S_StartSound
=
==================
*/

void S_StartSound(mobj_t *origin, int sound_id)
{
#ifdef JAGUAR
    sfxchannel_t	*channel, *newchannel;
    int 			i;
    int 		dist_approx;
    player_t 	*player;
    int 		dx, dy;
    short		vol;
    sfxinfo_t	*sfx;

    player = &players[consoleplayer];

    if (!origin || origin == player->mo)
        vol = 127;
    else
    {
        dx = abs(origin->x - player->mo->x);
        dy = abs(origin->y - player->mo->y);
        dist_approx = dx + dy - ((dx < dy ? dx : dy) >> 1);
        vol = dist_approx >> 20;
        if (vol > 127)
            return;
        vol = 127 - vol;
    }

    sfx = &S_sfx[sound_id];
    newchannel = NULL;

    for (channel=sfxchannels,i=0 ; i<SFXCHANNELS ; i++,channel++)
    {
        if (channel->sfx == sfx)
        {
            if (channel->startquad == finalquad)
                return;
            if (sfx->singularity)
            {
                newchannel = channel;
                goto gotchannel;
            }
        }
        if (channel->origin == origin)
        {
            newchannel = channel;
            goto gotchannel;
        }
        if (channel->stopquad <= finalquad)
            newchannel = channel;
    }

    if (!newchannel)
    {
        for (newchannel=sfxchannels,i=0 ; i<SFXCHANNELS ; i++, newchannel++)
            if (newchannel->sfx->priority >= sfx->priority)
                goto gotchannel;
        return;
    }

gotchannel:
    newchannel->sfx = sfx;
    newchannel->origin = origin;
    newchannel->startquad = finalquad;
    newchannel->stopquad = finalquad + (sfx->md_data->samples >> 2);
    newchannel->source = (int *)&sfx->md_data->data;	
    newchannel->volume = vol * (short)sfxvolume;
    channelschanged = true;
#endif
}

/*
===================
=
= S_UpdateSounds
=
===================
*/

extern	int	sfx_start;
extern	int music_dspcode;

void S_UpdateSounds(void) 
{
    int st;

    if (!sfxvolume) 
    {
        if (oldsfxvolume) 
        {
            oldsfxvolume = 0;
            S_Clear();
        }
        return;
    } else {
        if (!oldsfxvolume)
            finalquad = (samplecount >> 3) - 100;
        oldsfxvolume = sfxvolume;
    }

    soundstarttics = samplecount;

    if (music) 
    {
        if (!musictime)
            musictime = next_eventtime = samplecount + EXTERN_BUFFER_SIZE/2;
        while (samplecount - musictime > EXTERN_BUFFER_SIZE) 
        {
            musictime += EXTERN_BUFFER_SIZE;
            next_eventtime += EXTERN_BUFFER_SIZE;
        }

        st = samplecount;
        DSPFunction(&music_dspcode);  /* Music first */
        musictics = samplecount - st;

        if (channelschanged) 
        {
            st = samplecount;
            sfxsample = samplecount;
            dspfinished = 0x1234;
            dspcodestart = (int)&sfx_start;
            DSPFunction(&sfx_start);  /* SFX second */
            soundtics = samplecount - st;
            channelschanged = false;
            finalquad = samplecount >> 3;
        }
    }
    else 
    {
        st = samplecount;
        dspfinished = 0x1234;
        dspcodestart = (int)&sfx_start;
        DSPFunction(&sfx_start);
        soundtics = samplecount - st;
        finalquad = samplecount >> 3;
    }
}
void S_StartSong(int music_id, int looping)
{
    int lump;

    next_eventtime = musictime;
    musicvolume = 64;
    musictime = 0;
    samples_per_midiclock = 0;
    lump = W_GetNumForName(S_music[music_id].name);
    music_memory = music = 
        (unsigned char *) W_CacheLumpNum(lump, PU_STATIC);
    music_start = looping ? music : 0;
    music_end = (unsigned char *) music + lumpinfo[lump].size;
}

void S_StopSong(void)
{
    int i;
    int *ptr;

    if (music_memory)
    {
        Z_Free(music_memory);
        music_memory = 0;
    }
    music = 0;

    ptr = soundbuffer + 1;
    if (soundbuffer)
    {
        for (i = (EXTERNALQUADS * 32) / 4; i > 0; i -= 8)
        {
            ptr[0] = 0;
            ptr[2] = 0;
            ptr[4] = 0;
            ptr[6] = 0;
            ptr += 8;
            if (ptr >= soundbuffer + (EXTERNALQUADS * 32) / 4)
                break;
        }
    }
}