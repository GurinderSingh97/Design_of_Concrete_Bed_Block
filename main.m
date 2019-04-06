% Design of Concrete Bed Block
clc
clear

load input.mat
load value.mat
disp("Design of Concrete Bed Block")
disp("\n")
disp("When Concrete Bed Block is below the main beam")
% Length of block
Length_of_block = ceil((Reaction/(Permissible_Compressive_Stress*Effective_thickness_of_wall*1000))/100)*100;
printf("Length_of_block = %d mm \n", Length_of_block)

% Depth of block
Depth_of_block = ceil(((Length_of_block-(Width_of_beam*1000))/2)/10)*10;
printf("Depth_of_block = %d mm \n", Depth_of_block)

disp("\n")
Reaction_from_main_beam = (Reaction/1000);
printf("Reaction_from_main_beam = %d KN \n", Reaction_from_main_beam)

Moment = (((Permissible_Compressive_Stress*(Effective_thickness_of_wall*1000))*((Length_of_block/2))*(Length_of_block-(Length_of_block/2)))/2)/1000000
Mu = 1.5*Moment;
printf("Factored_Moment = %d kNm \n", Mu)

Area_of_steel_required = 0.5*(fck/fy)*(1-sqrt(1-((4.6*Mu*1000000)/(fck*Effective_thickness_of_wall*1000*Depth_of_block*Depth_of_block))))*Effective_thickness_of_wall*1000*Depth_of_block;

Minimum_area_of_steel = (0.85*Effective_thickness_of_wall*1000*Depth_of_block)/fy;

if(Area_of_steel_required>Minimum_area_of_steel)
Area_of_steel = Area_of_steel_required;
printf("Area_of_steel = %d mm^2 \n", Area_of_steel)
elseif(Area_of_steel_required<Minimum_area_of_steel)
Area_of_steel = Minimum_area_of_steel;
printf("Area_of_steel = %d mm^2 \n", Area_of_steel)
endif
pt = (100*Area_of_steel)/((Effective_thickness_of_wall*1000)*Depth_of_block);
printf("Percentage_of_steel = %d %% \n", pt)
dia_of_reinforced_bar = dia;
printf("dia_of_reinforced_bar = %d mm \n", dia_of_reinforced_bar)
Area_of_one_bar = (pi/4)*dia*dia;
printf("Area_of_one_bar = %d mm^2 \n", Area_of_one_bar)
No_of_reinforced_bars = round(Area_of_steel/Area_of_one_bar)

disp("\n")
disp("When main beam is embedded in the concrete bed block")
Length_of_block = ceil((Reaction/(Permissible_Compressive_Stress*Effective_thickness_of_wall*1000))/100)*100;
printf("Length_of_block = %d mm \n", Length_of_block)

% Depth of block
Depth_of_block = ceil(((Length_of_block-(Width_of_beam*1000))/2)/10)*10;
if(Depth_of_block>(Depth_of_beam*1000))
Depth_of_block = Depth_of_beam*1000;
printf("Depth_of_block = %d mm \n", Depth_of_block)
elseif(Depth_of_block<(Depth_of_beam*1000))
Depth_of_block = Depth_of_block;
printf("Depth_of_block = %d mm \n", Depth_of_block)
endif

disp("\n")
disp("Check for Shear Reinforcement")
v = Permissible_Compressive_Stress*Effective_thickness_of_wall*1000;
Distance_for_side_of_block_to_face_of_main_beam = ((Length_of_block) - (Width_of_beam*1000))/2;
V = (v*((Length_of_block/2)-(Distance_for_side_of_block_to_face_of_main_beam)))/1000;
printf("Shear_force_at_face_of_main_beam = %d KN \n", V)
tv = V*1000/((Effective_thickness_of_wall*1000)*Depth_of_block);
printf("Actual_shear_stress = %d N/mm^2 \n", tv)
tc = Permissible_Shear_Stress1 = interp2(tables,tables,tables,fck,pt);
printf("Permissible_shear_stress = %d N/mm^2 \n", tc)
if(tv<tc)
disp("No_shear_reinforcement_is_necessary")
elseif(tv>tc)
Asv = no_of_legged*(pi/4)*dia_s*dia_s;
% Spacing of stirrups
disp("Shear_reinforcement_is_necessary")
sv = (2.175*Asv*fy)/(Effective_thickness_of_wall*1000);
s = 0.75*Depth_of_block;
Spacing_between_stirrups = min([sv,s,300]);
printf("Spacing_between_stirrups = %d mm \n", Spacing_between_stirrups)
endif