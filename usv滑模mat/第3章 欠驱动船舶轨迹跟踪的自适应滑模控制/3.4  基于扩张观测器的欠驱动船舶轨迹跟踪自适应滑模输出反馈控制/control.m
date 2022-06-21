function [sys,x0,str,ts] = control(t,x,u,flag)

switch flag,

  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;

  case 1,
    sys=mdlDerivatives(t,x,u);

  case 2,
    sys=mdlUpdate(t,x,u);

  case 3,
    sys=mdlOutputs(t,x,u);

  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  case 9,
    sys=mdlTerminate(t,x,u);

  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

function [sys,x0,str,ts]=mdlInitializeSizes


sizes = simsizes;

sizes.NumContStates  = 82;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 12;
sizes.NumInputs      = 15;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);
str = [];
ts  = [0 0];
x0=0*ones(1,82);
global  c1 bb1 bb2 c2 c3
% c1=[-6 -5.7 -5.4 -5.1 -4.8 -4.5 -4.2 -3.9 -3.6 -3.3 -3 -2.7 -2.4 -2.1 -1.8 -1.5 -1.2 -0.9 -0.6 -0.3 0 0.3 0.6 0.9 1.2 1.5 1.8 2.1 2.4 2.7 3 3.3 3.6 3.9 4.2 4.5 4.8 5.1 5.4 5.7 6;
%     -1 -0.95 -0.9 -0.85 -0.8 -0.75 -0.7 -0.65 -0.6 -0.55 -0.5 -0.45 -0.4 -0.35 -0.3 -0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1;
%     -1 -0.95 -0.9 -0.85 -0.8 -0.75 -0.7 -0.65 -0.6 -0.55 -0.5 -0.45 -0.4 -0.35 -0.3 -0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];
% c1=[-6 -5.7 -5.4 -5.1 -4.8 -4.5 -4.2 -3.9 -3.6 -3.3 -3 -2.7 -2.4 -2.1 -1.8 -1.5 -1.2 -0.9 -0.6 -0.3 0 0.3 0.6 0.9 1.2 1.5 1.8 2.1 2.4 2.7 3 3.3 3.6 3.9 4.2 4.5 4.8 5.1 5.4 5.7 6];
% c1=1*[0 0.15 0.3 0.45 0.6 0.75 0.9 1.05 1.2 1.35 1.5 1.65 1.8 1.95 2.1 2.25 2.4 2.55 2.7 2.85 3 3.15 3.3 3.45 3.6 3.75 3.9 4.05 4.2 4.35 4.5 4.65 4.8 4.95 5.1 5.25 5.4 5.55 5.7 5.85 6];
%
c1=[-3*6 -3*5.7 -3*5.4 -3*5.1 -3*4.8 -3*4.5 -3*4.2 -3*3.9 -3*3.6 -3*3.3 -3*3 -3*2.7 -3*2.4 -3*2.1 -3*1.8 -3*1.5 -3*1.2 -3*0.9 -3*0.6 -3*0.3 0 3*0.3 3*0.6 3*0.9 3*1.2 3*1.5 3*1.8 3*2.1 3*2.4 3*2.7 3*3 3*3.3 3*3.6 3*3.9 3*4.2 3*4.5 3*4.8 3*5.1 3*5.4 3*5.7 3*6;
    -1 -0.95 -0.9 -0.85 -0.8 -0.75 -0.7 -0.65 -0.6 -0.55 -0.5 -0.45 -0.4 -0.35 -0.3 -0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1;
    -0.5*1 -0.5*0.95 -0.5*0.9 -0.5*0.85 -0.5*0.8 -0.5*0.75 -0.5*0.7 -0.5*0.65 -0.5*0.6 -0.5*0.55 -0.5*0.5 -0.5*0.45 -0.5*0.4 -0.5*0.35 -0.5*0.3 -0.5*0.25 -0.5*0.2 -0.5*0.15 -0.5*0.1 -0.5*0.05 0 0.5*0.05 0.5*0.1 0.5*0.15 0.5*0.2 0.5*0.25 0.5*0.3 0.5*0.35 0.5*0.4 0.5*0.45 0.5*0.5 0.5*0.55 0.5*0.6 0.5*0.65 0.5*0.7 0.5*0.75 0.5*0.8 0.5*0.85 0.5*0.9 0.5*0.95 0.5*1;
    -0.01*1 -0.01*0.95 -0.01*0.9 -0.01*0.85 -0.01*0.8 -0.01*0.75 -0.01*0.7 -0.01*0.65 -0.01*0.6 -0.01*0.55 -0.01*0.5 -0.01*0.45 -0.01*0.4 -0.01*0.35 -0.01*0.3 -0.01*0.25 -0.01*0.2 -0.01*0.15 -0.01*0.1 -0.01*0.05 0 0.01*0.05 0.01*0.1 0.01*0.15 0.01*0.2 0.01*0.25 0.01*0.3 0.01*0.35 0.01*0.4 0.01*0.45 0.01*0.5 0.01*0.55 0.01*0.6 0.01*0.65 0.01*0.7 0.01*0.75 0.01*0.8 0.01*0.85 0.01*0.9 0.01*0.95 0.01*1;
    -0.1 -0.095 -0.09 -0.085 -0.08 -0.075 -0.07 -0.065 -0.06 -0.055 -0.05 -0.045 -0.04 -0.035 -0.03 -0.025 -0.02 -0.015 -0.01 -0.005 0 0.005 0.01 0.015 0.02 0.025 0.03 0.035 0.04 0.045 0.05 0.055 0.06 0.065 0.07 0.075 0.08 0.085 0.09 0.095 0.1];
%xi=[u;v;r;ue;dalfu]
c2=[-1 -0.95 -0.9 -0.85 -0.8 -0.75 -0.7 -0.65 -0.6 -0.55 -0.5 -0.45 -0.4 -0.35 -0.3 -0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1
    -0.01*1 -0.01*0.95 -0.01*0.9 -0.01*0.85 -0.01*0.8 -0.01*0.75 -0.01*0.7 -0.01*0.65 -0.01*0.6 -0.01*0.55 -0.01*0.5 -0.01*0.45 -0.01*0.4 -0.01*0.35 -0.01*0.3 -0.01*0.25 -0.01*0.2 -0.01*0.15 -0.01*0.1 -0.01*0.05 0 0.01*0.05 0.01*0.1 0.01*0.15 0.01*0.2 0.01*0.25 0.01*0.3 0.01*0.35 0.01*0.4 0.01*0.45 0.01*0.5 0.01*0.55 0.01*0.6 0.01*0.65 0.01*0.7 0.01*0.75 0.01*0.8 0.01*0.85 0.01*0.9 0.01*0.95 0.01*1;];
% c3=0.5*[-1 -0.95 -0.9 -0.85 -0.8 -0.75 -0.7 -0.65 -0.6 -0.55 -0.5 -0.45 -0.4 -0.35 -0.3 -0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];
c3=[-3*6 -3*5.7 -3*5.4 -3*5.1 -3*4.8 -3*4.5 -3*4.2 -3*3.9 -3*3.6 -3*3.3 -3*3 -3*2.7 -3*2.4 -3*2.1 -3*1.8 -3*1.5 -3*1.2 -3*0.9 -3*0.6 -3*0.3 0 3*0.3 3*0.6 3*0.9 3*1.2 3*1.5 3*1.8 3*2.1 3*2.4 3*2.7 3*3 3*3.3 3*3.6 3*3.9 3*4.2 3*4.5 3*4.8 3*5.1 3*5.4 3*5.7 3*6;
    -1 -0.95 -0.9 -0.85 -0.8 -0.75 -0.7 -0.65 -0.6 -0.55 -0.5 -0.45 -0.4 -0.35 -0.3 -0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1;
    -0.5*1 -0.5*0.95 -0.5*0.9 -0.5*0.85 -0.5*0.8 -0.5*0.75 -0.5*0.7 -0.5*0.65 -0.5*0.6 -0.5*0.55 -0.5*0.5 -0.5*0.45 -0.5*0.4 -0.5*0.35 -0.5*0.3 -0.5*0.25 -0.5*0.2 -0.5*0.15 -0.5*0.1 -0.5*0.05 0 0.5*0.05 0.5*0.1 0.5*0.15 0.5*0.2 0.5*0.25 0.5*0.3 0.5*0.35 0.5*0.4 0.5*0.45 0.5*0.5 0.5*0.55 0.5*0.6 0.5*0.65 0.5*0.7 0.5*0.75 0.5*0.8 0.5*0.85 0.5*0.9 0.5*0.95 0.5*1;
     -0.03*1 -0.03*0.95 -0.03*0.9 -0.03*0.85 -0.03*0.8 -0.03*0.75 -0.03*0.7 -0.03*0.65 -0.03*0.6 -0.03*0.55 -0.03*0.5 -0.03*0.45 -0.03*0.4 -0.03*0.35 -0.03*0.3 -0.03*0.25 -0.03*0.2 -0.03*0.15 -0.03*0.1 -0.03*0.05 0 0.03*0.05 0.03*0.1 0.03*0.15 0.03*0.2 0.03*0.25 0.03*0.3 0.03*0.35 0.03*0.4 0.03*0.45 0.03*0.5 0.03*0.55 0.03*0.6 0.03*0.65 0.03*0.7 0.03*0.75 0.03*0.8 0.03*0.85 0.03*0.9 0.03*0.95 0.03*1;
    -0.015*1 -0.015*0.95 -0.015*0.9 -0.015*0.85 -0.015*0.8 -0.015*0.75 -0.015*0.7 -0.015*0.65 -0.015*0.6 -0.015*0.55 -0.015*0.5 -0.015*0.45 -0.015*0.4 -0.015*0.35 -0.015*0.3 -0.015*0.25 -0.015*0.2 -0.015*0.15 -0.015*0.1 -0.015*0.05 0 0.015*0.05 0.015*0.1 0.015*0.15 0.015*0.2 0.015*0.25 0.015*0.3 0.015*0.35 0.015*0.4 0.015*0.45 0.015*0.5 0.015*0.55 0.015*0.6 0.015*0.65 0.015*0.7 0.015*0.75 0.015*0.8 0.015*0.85 0.015*0.9 0.015*0.95 0.015*1;
    -0.1 -0.095 -0.09 -0.085 -0.08 -0.075 -0.07 -0.065 -0.06 -0.055 -0.05 -0.045 -0.04 -0.035 -0.03 -0.025 -0.02 -0.015 -0.01 -0.005 0 0.005 0.01 0.015 0.02 0.025 0.03 0.035 0.04 0.045 0.05 0.055 0.06 0.065 0.07 0.075 0.08 0.085 0.09 0.095 0.1;
     -0.1 -0.095 -0.09 -0.085 -0.08 -0.075 -0.07 -0.065 -0.06 -0.055 -0.05 -0.045 -0.04 -0.035 -0.03 -0.025 -0.02 -0.015 -0.01 -0.005 0 0.005 0.01 0.015 0.02 0.025 0.03 0.035 0.04 0.045 0.05 0.055 0.06 0.065 0.07 0.075 0.08 0.085 0.09 0.095 0.1;
      -0.03*1 -0.03*0.95 -0.03*0.9 -0.03*0.85 -0.03*0.8 -0.03*0.75 -0.03*0.7 -0.03*0.65 -0.03*0.6 -0.03*0.55 -0.03*0.5 -0.03*0.45 -0.03*0.4 -0.03*0.35 -0.03*0.3 -0.03*0.25 -0.03*0.2 -0.03*0.15 -0.03*0.1 -0.03*0.05 0 0.03*0.05 0.03*0.1 0.03*0.15 0.03*0.2 0.03*0.25 0.03*0.3 0.03*0.35 0.03*0.4 0.03*0.45 0.03*0.5 0.03*0.55 0.03*0.6 0.03*0.65 0.03*0.7 0.03*0.75 0.03*0.8 0.03*0.85 0.03*0.9 0.03*0.95 0.03*1];

bb1=5;
bb2=2;


function sys=mdlDerivatives(t,x,u)
global  c1 bb1 bb2 c3
alfu=u(1);
alfv=u(2);
dalfu=u(3);
dalfv=u(4);
s1=u(5);
s2=u(6);
f_dot=u(7);
ue=u(8);
ut=u(9);
dv=u(10);
v=u(11);
r=u(12);
ddv=u(13);

xi1=[ut;v;r;ue;dalfu];
xi2=[ut;v;r;ddv;dv;dalfu;dalfv;f_dot];
h1=zeros(41,1);
for j=1:1:41
    h1(j)=exp(-norm(xi1-c1(:,j))^2/(2*bb1^2));
end
h2=zeros(41,1);
for j=1:1:41
    h2(j)=exp(-norm(xi2-c3(:,j))^2/(2*bb2^2));
end

HH=[h1;h2];

% a1=1*10^3;b1=10^(-8);
% a1=3.0*10^3;b1=10^(-8);
% a1=1.8*10^3;b1=10^(-8);%benwen
% a1=3.0*10^6;b1=0.5*10^(-9);%��ʼ״̬
% a1=2.0*10^6;b1=0.5*10^(-8);
a1=2*10^6;b1=1*10^(-6);
for i=1:1:41
    W1=x(i);
    sys(i)=a1*(-HH(i)*s1-b1*W1);
end
% a2=1*10^6;b2=10^(-8);
% a2=1*10^5;b2=10^(-6);%��ʼ״̬
% a2=1*10^7;b2=10^(-6);
a2=1*10^7;b2=8*10^(-7);%��ͨѧϰNN�Ա���
for i=42:1:82
    W2=x(i);
    sys(i)=a2*(-HH(i)*s2-b2*W2);
end



function sys=mdlUpdate(t,x,u)

sys = [];

function sys=mdlOutputs(t,x,u)
global  c1 bb1 bb2 c3
eta1=1*10^4;
eta2=1*10^4;
lamda1=1;lamda2=1;
m11=1.2*10^5;m22=1.779*10^5;m33=6.36*10^7;
d11=2.15*10^4;d22=1.47*10^5;d33=8.02*10^6;
du2=0.2*d11;dv2=0.2*d22;dr2=0.2*d33;
du3=0.1*d11;dv3=0.1*d22;dr3=0.2*d33;
alfu=u(1);
alfv=u(2);
dalfu=u(3);
dalfv=u(4);
s1=u(5);
s2=u(6);
f_dot=u(7);
ue=u(8);
ut=u(9);
dv=u(10);
v=u(11);
r=u(12);
ddv=u(13);
Twu=u(14);
Twr=u(15);

twu0=0.0;
twr0=0.0;
% gama1=1*10^5;
% gama2=0.2*10^6;
% rou1=1.5*10^(-7);
% rou2=2*10^(-8);
% gama1=1*10^5;
% gama1=1*10^5;
% gama2=2*10^5;
% gama1=6.5*10^4;%��ʼ״̬
% gama2=0.7*10^5;%��ʼ״̬
% gama1=6.35*10^4;%20170411
% gama1=5.5*10^4;
gama1=7.5*10^4;
gama2=1.5*10^4;
% gama1=9*10^4;
% gama2=5*10^4;
% rou1=0.25*10^(-7);
% rou1=1*10^(-9);%��ʼ״̬
% rou2=10*10^(-9);%��ʼ״̬
% rou1=4*10^(-10);%20170411
rou1=3*10^(-9);
rou2=7*10^(-9);
% rou1=3*10^(-9);
% rou2=7*10^(-9);
deta1=0.2;
deta2=0.02;
% DTwu=gama1*(abs(s1)-rou1*(Twu-twu0));
% DTwr=gama2*(abs(s2)-rou2*(Twr-twr0));
DTwu=gama1*(s1*tanh(0.2785*s1/deta1)-rou1*(Twu-twu0));
DTwr=gama2*(s2*tanh(0.2785*s2/deta2)-rou2*(Twr-twr0));
%���Ž������Ӧ����.



W1=[x(1) x(2) x(3) x(4) x(5) x(6) x(7) x(8) x(9) x(10) x(11) x(12) x(13) x(14) x(15) x(16) x(17) x(18) x(19) x(20) x(21) x(22) x(23) x(24) x(25) x(26) x(27) x(28) x(29) x(30) x(31) x(32) x(33) x(34) x(35) x(36) x(37) x(38) x(39) x(40) x(41)];
W2=[x(42) x(43) x(44) x(45) x(46) x(47) x(48) x(49) x(50) x(51) x(52) x(53) x(54) x(55) x(56) x(57) x(58) x(59) x(60) x(61) x(62) x(63) x(64) x(65) x(66) x(67) x(68) x(69) x(70) x(71) x(72) x(73) x(74) x(75) x(76) x(77) x(78) x(79) x(80) x(81) x(82)];

xi1=[ut;v;r;ue;dalfu];
xi2=[ut;v;r;ddv;dv;dalfu;dalfv;f_dot];
h1=zeros(41,1);
for j=1:1:41
    h1(j)=exp(-norm(xi1-c1(:,j))^2/(2*bb1^2));
end
h2=zeros(41,1);
for j=1:1:41
    h2(j)=exp(-norm(xi2-c3(:,j))^2/(2*bb2^2));
end

deta_fu=W1*h1;
deta_fr=W2*h2;
% deta_fu=du2*abs(ut)*ut+du3*(abs(ut))^2*ut;
% deta_fv=dv2*abs(v)*v+dv3*(abs(v))^2*v;
% deta_fr=dr2*abs(r)*r+dr3*(abs(r))^2*r;
% fu=(m22*v*r-d11*ut-deta_fu)/1;
% fv=(-m11*ut*r-d22*v-deta_fv)/1;
% fr=((m11-m22)*ut*v-d33*r-deta_fr)/1;

delta=0.02;
kk=0.2785;
% taou=-lamda1*m11*ue+m11*dalfu-(m22*v*r-d11*ut-deta_fu)-eta1*s1-Twu*tanh(kk*s1/delta);
taou=-(-deta_fu)-eta1*s1-Twu*tanh(kk*s1/delta);
FU=-lamda1*m11*ue+m11*dalfu-(m22*v*r-d11*ut);
% taou=-m22*v*r+d11*ut+m11*deta_fu+m11*dalfu-lamda1*m11*ue-eta1*s1-Twu*tanh(kk*s1/delta);
% hh=-(m22*alfu*((m11-m22)*ut*v-d33*r)+m22*m33*(r*dalfu-f_dot+lamda2*(dv-dalfv)-Ddeta_fv-deta_fr*alfu)-m11*m33*dut*r-m11*(m11-m22)*ut^2*v+m11*d33*ut*r-d22*m33*dv+m11*m33*ut*deta_fr);
% b=m22*alfu-m11*ut;
% taor=hh/b-Twr*tanh(kk*s2/delta)-eta2*s2;
% taor=-m33*(ddv-r*dalfu+f_dot+lamda2*(dv-dalfv))/alfu-((m11-m22)*ut*v-d33*r-deta_fr)-Twr*tanh(kk*s2/delta)-eta2*s2;
taor=-(-deta_fr)-Twr*tanh(kk*s2/delta)-eta2*s2;
FR=-m33*(ddv-r*dalfu+f_dot+lamda2*(dv-dalfv))/(alfu+13)-((m11-m22)*ut*v-d33*r);
sys(1)=taou;
sys(2)=taor;
sys(3)=Twu;
sys(4)=Twr;
sys(5)=deta_fu;
sys(6)=deta_fr;
sys(7)=FU;
sys(8)=FR;
sys(9)=DTwu;
sys(10)=DTwr;
sys(11)=0;
sys(12)=0;
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;


function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
