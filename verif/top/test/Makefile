# Makefile For Verdi

all: comp simulate

genf: 
	find -name "*.sv">verif.f
	
comp: clean com
com:
	cd ${SIM_PATH}; \
	vcs -R -full64 +v2k -kdb -sverilog  \
		-debug_all -l ${SIM_PATH}/vcs.log -timescale=1ns/1ps \
		-Mdir=${SIM_PATH}/csrc/ \
		-o ${SIM_PATH}/simv \
		-P ${VERDI_HOME}/share/PLI/VCS/LINUX64/novas.tab ${VERDI_HOME}/share/PLI/VCS/LINUX64/pli.a \
		-f ${VERIF_HOME}/top/flist/tb.f
cov:
	dve -covdir simv.vdb&
simulate:
	${SIM_PATH}/simv +UVM_TESTNAME=simple_soc_base_test -l ${SIM_PATH}/sim.log                

dve:
	dve \
	-vpd *.vpd &                     

verdi:
	verdi \
	-f verif.f \                     
	-nologo \
	-ssf *.fsdb &                    

clean:
	@rm -rf csrc DVEfiles simv simv.daidir ucli.key VCS* *.vdb
	@rm -rf *.log *.vpd *.ddc *.svf *.SDF *Synth *Netlist* *.h
	@rm -rf alib-52 work
	@rm -rf *.conf *.rc *.fsdb verdiLog



