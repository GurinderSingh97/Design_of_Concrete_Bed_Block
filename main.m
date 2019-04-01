% Design of Concrete Bed Block
clc
clear

load input.mat
load value.mat
disp("Design of Concrete Bed Block")
disp("\n")
% Length of block
Length_of_block = ceil((Reaction/(Permisible_Compressive_Stress*Effective_thickness_of_wall*1000))/100)*100;
printf("Length_of_block = %d mm \n", Length_of_block)

% Depth of block
Depth_of_block = ceil(((Length_of_block-(Width_of_beam*1000))/2)/10)*10;
printf("Depth_of_block = %d mm \n", Depth_of_block)

Stress_due_to_beam_load = (Reaction/(Effective_thickness_of_wall*1000*Length_of_block));
printf("Stress_due_to_beam_load = %d N/mm^2 \n", Stress_due_to_beam_load)

Stress_due_to_self_laod = (((Unit_weight_brick*1000*Overall_thickness_of_wall*(Height_of_papapet_wall+Depth_of_beam+(Depth_of_block/1000)))/(Effective_thickness_of_wall*10000)))/100;
printf("Stress_due_to_self_laod = %d N/mm^2 \n", Stress_due_to_self_laod)

Overall_Stress = Stress_due_to_beam_load+Stress_due_to_self_laod;
printf("Overall_Stress = %d N/mm^2 \n", Overall_Stress)

if(Overall_Stress<Permisible_Compressive_Stress)
disp("Hence Safe")
elseif(Overall_Stress>Permisible_Compressive_Stress)
disp("Hence Not Safe")
endif

disp("\n")
Reaction_from_main_beam = (Reaction/1000);
printf("Reaction_from_main_beam = %d KN \n", Reaction_from_main_beam)
 
Self_weight_of_concrete_block = Unit_weight_concrete*(Depth_of_block/1000)*(Effective_thickness_of_wall);
printf("Self_weight_of_concrete_block = %d KN/m \n", Self_weight_of_concrete_block)

Moment_from_reaction = (Reaction_from_main_beam*(Length_of_block/1000))/4;
Factored_Moment_from_reaction = 1.5*Moment_from_reaction;

Area_of_steel_required = 0.5*(fck/fy)*(1-sqrt(1-((4.6*Factored_Moment_from_reaction*1000000)/(fck*Effective_thickness_of_wall*1000*Depth_of_block*Depth_of_block))))*Effective_thickness_of_wall*1000*Depth_of_block;

Minimum_area_of_steel = (0.85*Effective_thickness_of_wall*1000*Depth_of_block)/fy;

if(Area_of_steel_required>Minimum_area_of_steel)
Area_of_steel = Area_of_steel_required;
printf("Area_of_steel = %d mm^2 \n", Area_of_steel)
elseif(Area_of_steel_required<Minimum_area_of_steel)
Area_of_steel = Minimum_area_of_steel;
printf("Area_of_steel = %d mm^2 \n", Area_of_steel)
endif

Area_of_one_bar = (pi/4)*dia*dia;
printf("Area_of_one_bar = %d mm^2 \n", Area_of_one_bar)
No_of_reinforced_bars = round(Area_of_steel/Area_of_one_bar)
disp("\n")
Shear_force = Reaction_from_main_beam/2;
printf("Shear_force = %d KN \n", Shear_force)
tv = Shear_force*1000/((Effective_thickness_of_wall*1000)*Depth_of_block);
printf("Actual_shear_stress = %d N/mm^2 \n", tv)
pt = (100*Area_of_steel)/((Effective_thickness_of_wall*1000)*Depth_of_block);
printf("Percentage_of_steel = %d %% \n", pt)
tc = Permissible_Shear_Stress1 = interp2(tables,tables,tables,fck,pt);
printf("Permissible_shear_stress = %d N/mm^2 \n", tc)
if(tv<tc)
disp("No_shear_reinforcement_is_necessary")
elseif(tv>tc)
Asv = no_of_legged*(pi/4)*d*d;
% Spacing of stirrups
disp("Shear_reinforcement_is_necessary")
sv = (2.175*Asv*fy)/(Effective_thickness_of_wall*1000);
s = 0.75*Depth_of_block;
Spacing_between_stirrups = min([sv,s,300]);
printf("Spacing_between_stirrups = %d mm \n", Spacing_between_stirrups)
endif