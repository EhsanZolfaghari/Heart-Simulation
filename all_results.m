clc;
close all;

RVV=RVP/E;


RVV_data = RVV.Data;
RVP_data = RVP.Data;


stable_start = 2000; 
stable_end = 5000;   

RVV_stable = RVV_data(stable_start:stable_end);
RVP_stable = RVP_data(stable_start:stable_end);


LVV=LVP/E;

LVV_data = LVV.Data;
LVP_data = LVP.Data; 


stable_start = 4000; 
stable_end = 5000;  

LVV_stable = LVV_data(stable_start:stable_end);
LVP_stable = LVP_data(stable_start:stable_end);


figure(1);
plot(LVV_stable, LVP_stable, 'g-', 'LineWidth', 2);
title('PV-loop');
xlabel('Left Venticular Volume(ml)');
ylabel('Left Venticular Pressure(mmhg)');
grid on;
legend ( 'LVP and LVV')

figure(2);
plot(RVV_stable, RVP_stable, 'g-', 'LineWidth', 2); 
title('PV-loop');
xlabel('Reft Venticular Volume(ml)');
ylabel('Reft Venticular Pressure(mmhg)');
grid on;
legend ( 'RVP and RVV')


figure(3);
plot(RAP ,'g-', 'linewidth' , 1)
hold on 
plot(PP,'r-','linewidth' , 1)
plot(RVP,'b', 'linewidth' , 1)
xlabel('Time(sec)')
ylabel('mmHg')
legend ('Right Atrial Pressure' , 'Pulmonary Pressure' , 'Right Venticular Pressure')
hold off
title('Results of RAP PP RVP') 



figure(4);
plot(LVP ,'r-', 'linewidth' , 1)
hold on 
plot(AP,'b-','linewidth' , 1)
xlabel('Time(sec)')
ylabel('mmHg')
legend ( 'Left Venticular Pressure', 'Aortic Pressure' )
hold off
title('Results of LVP AP LAP') 



figure(5);
plot(AF ,'B-', 'linewidth' , 1)
xlabel('Time(sec)')
ylabel('ml')
legend ( 'Aortic Flow ' )
hold off
title('Result of Aortic Flow ') 

%Left
EDV_left = max(LVV_stable);
ESV_left = min(LVV_stable);


fprintf('EDV_left: %.2f mL\n', EDV_left);
fprintf('ESV_left: %.2f mL\n', ESV_left);

EF_left = ((EDV_left-ESV_left)/EDV_left)*100;
fprintf('EF: %.2f %\n', EF_left);

%right
EDV_right = max(RVV_stable);
ESV_right = min(RVV_stable);


fprintf('EDV_right: %.2f mL\n', EDV_right);
fprintf('ESV_right: %.2f mL\n', ESV_right);

EF_right = ((EDV_right-ESV_right)/EDV_right)*100;
fprintf('EF_right: %.2f %\n', EF_right);



min_LVP = min(LVP_stable); 
max_LVP = max(LVP_stable); 


fprintf('min_LVP: %.2f %\n', min_LVP);
fprintf('max_LVP: %.2f %\n',max_LVP);



if isa(AP, 'timeseries')
    y = AF.Data; 
    x = AF.Time; % 
else
    y = AF; 
    x = 0:length(AF);
end


indices = x >= 0; 
x_filtered = x(indices);
y_filtered = y(indices);

area_under_curve = trapz(x_filtered, y_filtered);


fprintf('AF in mitunes: %.2f ml%\n', area_under_curve);
