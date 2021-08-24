.POSIX:

.SUFFIXES: .scad .stl .png

OPENSCAD = openscad
OPENSCAD_FLAGS =

.scad.stl:
	$(OPENSCAD) $(OPENSCAD_FLAGS) -o $@ $<
.scad.png:
	$(OPENSCAD) --autocenter --viewall $(OPENSCAD_FLAGS) -o $@ $<

models: xcelite-99-blade-case.stl xcelite-99-blade-case-cap.stl
previews: xcelite-99-blade-case.png xcelite-99-blade-case-cap.png assembly.png

clean:
	rm -f xcelite-99-blade-case.stl xcelite-99-blade-case-cap.stl \
	      xcelite-99-blade-case.png xcelite-99-blade-case-cap.png assembly.png

help:
	@echo "available targets: models, previews, clean"
	@echo "influential macros:"
	@echo "    OPENSCAD:       openscad binary, currently: $(OPENSCAD)"
	@echo "    OPENSCAD_FLAGS: flags to pass to openscad, currently: $(OPENSCAD_FLAGS)"
	@echo "useful openscad defines (see common.scad for defaults and others):"
	@echo "    -D no_blades=[n]:       number of blade sockets to generate"
	@echo "    -D blade_angle=[theta]: angle to turn the blades' wings from horizontal in"
	@echo "                            degrees; 0 is minimal thickness, 90 is minimal width"
	@echo "    -D tool_spacing_x=[in]: space between two tools in inches; negative values"
	@echo "                            are of interest for angles between 0 and 90; try"
	@echo "                            increasing for nut drivers and other toolheads"
	@echo "                            bigger than the handle socket"
	@echo "    -D tool_spacing_y=[in]: space between tools and the case walls in inches;"
	@echo "                            increase for toolheads bigger than the handle socket"
	@echo "    -D solid_cap=true:      generate the cap as a solid rectangular block, for"
	@echo "                            printing in vase mode on FDM machines"
	@echo "    -D cutaway_x=true:      assembly.png will have the right half cut away"
	@echo "    -D cutaway_y=true:      assembly.png will have the front half cut away"
