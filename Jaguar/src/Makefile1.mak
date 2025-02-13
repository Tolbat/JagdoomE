
OFILES = \
init.o \
jagonly.o \
\
gpubase.o \
dspbase.o \
lastobj.o \
decomp.o \
eeprom.o \
\
f_main.o \
in_main.o \
am_main.o \
st_main.o \
m_main.o \
o_main.o \
\
comnjag.o \
vsprintf.o \
d_main.o \
g_game.o \
info.o \
p_ceilng.o \
p_doors.o \
p_enemy.o \
p_floor.o \
p_inter.o \
p_lights.o \
p_map.o \
p_maputl.o \
p_mobj.o \
p_plats.o \
p_pspr.o \
p_setup.o \
p_spec.o \
p_switch.o \
p_telept.o \
p_tick.o \
p_base.o \
p_user.o \
p_sight.o \
p_shoot.o \
p_move.o \
p_change.o \
p_slide.o \
r_main.o \
r_data.o \
r_phase1.o \
r_phase2.o \
r_phase3.o \
r_phase4.o \
r_phase5.o \
r_phase6.o \
r_phase7.o \
r_phase8.o \
r_phase9.o \
s_sound.o \
sounds.o \
sprinfo.o \
tables.o \
w_wad.o \
z_zone.o \
sfx.o	\
music.o

jagdoom : $(OFILES)
	aln -c mydoom.lnk 
#	rdbjag doom

GAS2OBJ = mac -fb $?
Cx2OBJ = gcc -x c++ -m68000 -Wall -DJAGUAR -O2  -c -o $@ $<

# C2OBJ = gcc263 -b m68k -Wall -DJAGUAR -O2 -c -o $@ $?
C2OBJ = gcc -B/jaguar/devkit/bin/ -b m68k -V2.6 -Wall -DJAGUAR -O2 -c -o $@ $?



#
# 68k jaguar specific asm files
#
init.o :init.s
#	cpp -DJAGUAR -DJAGPROFILE -lang-c++ -nostdinc $< $*.i
#	as -mc68000  -o $@ $*.i
	$(GAS2OBJ)
	
lastobj.o :lastobj.s
#	cpp -DJAGUAR -DJAGPROFILE -lang-c++ -nostdinc $< $*.i
#	as -mc68000  -o $@ $*.i
	$(GAS2OBJ)

eeprom.o : eeprom.gas
	$(GAS2OBJ)

#
# gpu/dsp jaguar specific asm files
#
gpubase.o : gpubase.gas
	$(GAS2OBJ)
dspbase.o : dspbase.gas
	$(GAS2OBJ)
decomp.o : decomp.gas
	$(GAS2OBJ)
		
#
# 68k jaguar specific C files
#	
jagonly.o : jagonly.c
	$(C2OBJ)

#
# non-gameloop files
#
f_main.o : f_main.c
	$(C2OBJ)
in_main.o : in_main.c
	$(C2OBJ)
am_main.o : am_main.c
	$(C2OBJ)
o_main.o : o_main.c
	$(C2OBJ)
st_main.o : st_main.c
	$(C2OBJ)
m_main.o : m_main.c
	$(C2OBJ)

#
# common files
#
comnjag.o : comnjag.c
	$(C2OBJ)
vsprintf.o : vsprintf.c
	$(C2OBJ)
d_main.o : d_main.c
	$(C2OBJ)
g_game.o : g_game.c
	$(C2OBJ)
info.o : info.c
	$(C2OBJ)
p_ceilng.o : p_ceilng.c
	$(C2OBJ)
p_doors.o : p_doors.c
	$(C2OBJ)
p_enemy.o : p_enemy.c
	$(C2OBJ)
p_floor.o : p_floor.c
	$(C2OBJ)
p_inter.o : p_inter.c
	$(C2OBJ)
p_lights.o : p_lights.c
	$(C2OBJ)
p_map.o : p_map.c
	$(C2OBJ)
p_maputl.o : p_maputl.c
	$(C2OBJ)
p_mobj.o : p_mobj.c
	$(C2OBJ)
p_plats.o : p_plats.c
	$(C2OBJ)
p_pspr.o : p_pspr.c
	$(C2OBJ)
p_setup.o : p_setup.c
	$(C2OBJ)
p_spec.o : p_spec.c
	$(C2OBJ)
p_switch.o : p_switch.c
	$(C2OBJ)
p_telept.o : p_telept.c
	$(C2OBJ)
p_tick.o : p_tick.c
	$(C2OBJ)
p_user.o : p_user.c
	$(C2OBJ)
#p_base.o : p_base.c
#	$(C2OBJ)
p_base.o : p_base.gas
	$(GAS2OBJ)
#p_sight.o : p_sight.c
#	$(C2OBJ)
p_sight.o : p_sight.gas
	$(GAS2OBJ)
#p_shoot.o : p_shoot.c
#	$(C2OBJ)
p_shoot.o : p_shoot.gas
	$(GAS2OBJ)
p_change.o : p_change.c
	$(C2OBJ)
#p_move.o : p_move.c
#	$(C2OBJ)
p_move.o : p_move.gas
	$(GAS2OBJ)
#p_slide.o : p_slide.c
#	$(C2OBJ)
p_slide.o : p_slide.gas
	$(GAS2OBJ)
	
	
r_main.o : r_main.c
	$(C2OBJ)
r_data.o : r_data.c
	$(C2OBJ)
s_sound.o : s_sound.c
	$(C2OBJ)
sounds.o : sounds.c
	$(C2OBJ)
sprinfo.o : sprinfo.c
	$(C2OBJ)
tables.o : tables.c
	$(C2OBJ)
w_wad.o : w_wad.c
	$(C2OBJ)
z_zone.o : z_zone.c
	$(C2OBJ)

#
# hand coded common files
#
#r_phase1.o : r_phase1.c
#	$(C2OBJ)
r_phase1.o : r_phase1.gas
	$(GAS2OBJ)
#r_phase2.o : r_phase2.c
#	$(C2OBJ)
r_phase2.o : r_phase2.gas
	$(GAS2OBJ)
#r_phase3.o : r_phase3.c
#	$(C2OBJ)
r_phase3.o : r_phase3.gas
	$(GAS2OBJ)
#r_phase4.o : r_phase4.c
#	$(C2OBJ)
r_phase4.o : r_phase4.gas
	$(GAS2OBJ)
#r_phase5.o : r_phase5.c
#	$(C2OBJ)
r_phase5.o : r_phase5.gas
	$(GAS2OBJ)
#r_phase6.o : r_phase6.c
#	$(C2OBJ)
r_phase6.o : r_phase6.gas
	$(GAS2OBJ)
#r_phase7.o : r_phase7.c
#	$(C2OBJ)
r_phase7.o : r_phase7.gas
	$(GAS2OBJ)
#r_phase8.o : r_phase8.c
#	$(C2OBJ)
r_phase8.o : r_phase8.gas
	$(GAS2OBJ)
r_phase9.o : r_phase9.gas
	$(GAS2OBJ)

sfx.o : sfx.gas
	$(GAS2OBJ)
music.o : music.gas
	$(GAS2OBJ)








boot:
	$(GAS2OBJ) boot.s
	aln -c myboot.lnk 




clean:
	del *.o
	del *.abs
	del temp*.bin
	del JagDoom.j64
	if exist C:\Jaguar\temp\*.* del C:\Jaguar\temp\*.*
	#copy /b init.sav init.o
	#disabled compile of init.s to use old init.sav

	
	
	
	#windows - pain in ass
	cd C:/Jaguar/src
	
rom:
	del C:\Jaguar\Temp\temp1.bin C:\Jaguar\Temp\temp2.bin C:\Jaguar\Temp\temp3.bin C:\Jaguar\Temp\JagDoom.j64
	copy /b Univ.bin+boot.abs+doom.abs C:\Jaguar\Temp\temp1.bin
	# Pause to run PadTempBin1 Py on your desktop cmd prompt - temp1.bin must be 256K
	

rom2:	
	copy /b C:\Jaguar\Temp\temp1.bin+doom.wad C:\Jaguar\Temp\temp2.bin
	copy /b C:\Jaguar\Temp\temp2.bin JagDoom.j64								   



#usb:
	#/cygdrive/c/Jaguar/src/JagGD.exe -rd
	#/cygdrive/c/Jaguar/src/JagGD.exe -u DOOM.ABS,a:0x2000
	#/cygdrive/c/Jaguar/src/JagGD.exe -u doom.wad,a:0x840000
	#/cygdrive/c/Jaguar/src/JagGD.exe -x 0x2000


#wad:
	# Pause this is done via a python script on windows cmd see read me
