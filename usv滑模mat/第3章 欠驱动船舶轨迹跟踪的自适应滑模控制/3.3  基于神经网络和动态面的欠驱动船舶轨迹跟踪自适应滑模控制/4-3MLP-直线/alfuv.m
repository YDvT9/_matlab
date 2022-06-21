function [sys,x0,str,ts] = alfuv(t,x,u,flag)

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

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 11;
sizes.NumInputs      = 10;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);


str = [];


ts  = [0 0];
x0=[];%u v r x y psi_d

function sys=mdlDerivatives(t,x,u)

sys=[];
function sys=mdlUpdate(t,x,u)

sys = [];

function sys=mdlOutputs(t,x,u)

k=1.0;

C=5;
lamda1=1;
lamda2=1;
xd=u(1);

dxd=10;
ddxd=0;
yd=u(2);

dyd=1;
ddyd=0;
xx=u(3);
y=u(4);
fai=u(5);
ut=u(6);
v=u(7);
r=u(8);
S_ue=u(9);
D_ve=u(10);
xe=xx-xd;
ye=y-yd;
A=[cos(fai) sin(fai);-sin(fai) cos(fai)];
W=-((xe)^2+(ye)^2+C)^(1/2);
B=[k*xe/W;k*ye/W];
bb1=[1 0]*B;
bb2=[0 1]*B;
D=[dxd+bb1;dyd+bb2];
ALF=A*D;
alfu=[1 0]*ALF;
alfv=[0 1]*ALF;

XEYE=B;
dxe=[1 0]*XEYE;
dye=[0 1]*XEYE;
F=[ddxd+k*(1/W-((1/W^3)*xe^2))*dxe-k*xe*ye*dye/(W^3);ddyd+k*(1/W-((1/W^3)*ye^2))*dye-k*xe*ye*dxe/(W^3)];
DALF=[r*alfv;-r*alfu]+A*F;
dalfu=[1 0]*DALF;
dalfv=[0 1]*DALF;
ue=ut-alfu;
ve=v-alfv;
ff=(ddyd+k*(1/W-((1/W^3)*ye^2))*dye-k*xe*ye*dxe/W^3)*cos(fai)-(ddxd+k*(1/W-((1/W^3)*xe^2))*dxe-k/W^3*xe*ye*dye)*sin(fai);
s1=lamda1*S_ue+ue;
s2=D_ve+lamda2*ve;
sys(1)=alfu;
sys(2)=alfv;
sys(3)=dalfu;
sys(4)=dalfv;
sys(5)=s1;
sys(6)=s2;
sys(7)=ff;
sys(8)=ue;
sys(9)=ve;
sys(10)=xe;
sys(11)=ye;
function sys=mdlGetTimeOfNextVarHit(t,x,u)
sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;


function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
