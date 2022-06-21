plot(x_r, y_r)
hold on
plot(x,y,'r')
grid on
%ylim([-200,200])
xlim([0,400])
legend ('Trajektoria referencyjna', 'Trajektoria rzeczywista')
title('Wykres po�o�enia')
xlabel('po�o�enie w osi X')
ylabel('po�o�enie w osi Y')
xlabel('po�o�enie w osi X [m]')
ylabel('po�o�enie w osi Y [m]')
saveas(gcf, 'linia jiang.png')

close

plot(t,e(:,1))
hold on
plot(t,e(:,2),'r')
grid on
legend ('Uchyb w osi x', 'Uchyb w osi y')
title('Wykres uchyb�w po�o�enia')
xlabel('czas [s]')
ylabel('uchyb [m]')
ylim([-10,10]);
saveas(gcf, 'uchyb polozenia linia jiang.png')

close

plot(t,e(:,3))
grid on
legend ('Uchyb orientacji')
title('Wykres uchybu orientacji')
xlabel('czas [s]')
ylabel('uchyb [st]')
ylim([-2,2]);
saveas(gcf, 'uchyb orientacji linia jiang.png')

close

plot(t, Tau_u)
grid on
% ylim([-200,200])
% xlim([0,1000])
legend ('Sygna� steruj�cy Tau_u')
title('Wykres sygna�u steruj�cego Tau_u')
xlabel('czas [s]')
ylabel('si�a wymuszaj�ca [N]')
saveas(gcf, 'Tau_u linia jiang.png')

close

plot(t, Tau_r)
grid on
% ylim([-200,200])
% xlim([0,1000])
legend ('Sygna� steruj�cy Tau_r')
title('Wykres sygna�u steruj�cego Tau_r')
xlabel('czas [s]')
ylabel('moment wymuszaj�cy [Nm]')
saveas(gcf, 'Tau_r linia jiang.png')

close

u_blad=x_r_dot-u;
plot(t, u_blad)
grid on
% ylim([-200,200])
% xlim([0,1000])
legend ('Uchyb pr�dko�ci u')
title('Wykres uchybu pr�dko�ci u')
xlabel('czas [s]')
ylabel('predko�� [m/s]')
saveas(gcf, 'u linia jiang.png')


close 

plot(t, v)
grid on
ylim([-3,3])
% xlim([0,1000])
legend ('Uchyb pr�dko�ci v')
title('Wykres uchybu pr�dko�ci v')
xlabel('czas [s]')
ylabel('predko�� [m/s]')
saveas(gcf, 'v linia jiang.png')

close 

plot(t, r)
grid on
% ylim([-200,200])
% xlim([0,1000])
legend ('Uchyb pr�dko�ci r')
title('Wykres uchybu pr�dko�ci r')
xlabel('czas [s]')
ylabel('predko�� [rad/s]')
saveas(gcf, 'r linia jiang.png')

close

plot(t, u_e)
grid on
% ylim([-200,200])
% xlim([0,1000])
legend ('Uchyb pr�dko�ci u_e')
title('Wykres uchybu pr�dko�ci wirtualnej u_e')
xlabel('czas [s]')
ylabel('predko�� [m/s]')
saveas(gcf, 'u_e sinus jiang.png')

close

plot(t, r_e)
grid on
% ylim([-200,200])
% xlim([0,1000])
legend ('Uchyb pr�dko�ci r_e')
title('Wykres uchybu pr�dko�ci wirtualnej r_e')
xlabel('czas [s]')
ylabel('predko�� [rad/s]')
saveas(gcf, 'r_e linia jiang.png')

close