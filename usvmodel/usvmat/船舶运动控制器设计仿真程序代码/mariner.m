function [xdot,U] = mariner(x,ui,U0)
% [xdot, U] = mariner(x,ui) ������ʵ�ٶ�U in m/s �Լ�״̬����x = [ u v r x y psi delta n ]'
%��ƫ��
% 
%��������У�
% u     = �볣���ٶ�Uo֮���ƫ�U0Ĭ��ֵΪU0 = 7.7175 m/s = 15 knots. 
% v     = ҡ���ٶ���0֮���ƫ�� (m/s)
% r     = ƫ�����ٶ���0֮���ƫ�� (rad/s)
% x     = x�����λ�� (m)
% y     = y�����λ�� (m)
% psi   = ƫ������0֮���ƫ�� (rad)
% delta  = ��ʵ�Ķ�ƫ�� (rad)
% ui    = ���ƶ��ָ��(rad)�������������
% U0    = �����ٶ� (m/s)

% �������
% xdotΪ״̬������΢��
% U    = ��ʵ�ٶ� (m/s)

% ȷ������ֵ�Ƿ����Ҫ��
% ������벻��7ά�������������Ϣ
if (length(x)  ~= 7),error('x-vector must have dimension 7 !'); end  
% ������ƶ��ָ���1ά�������������Ϣ
if (length(ui) ~= 1),error('ui must be a scalar input!'); end
% ���û������U0��Ϣ�������Ĭ��ֵ
if nargin==2, U0 = 7.7175; end
 
% �Ա�����ֵ����һ��
L = 160.93;
U = sqrt((U0 + x(1))^2 + x(2)^2);  % ��ʵ�ٶ�
delta_c = -ui;   
u     = x(1)/U;   
v     = x(2)/U;  
r     = x(3)*L/U; 
psi    = x(6); 
delta  = x(7); 
delta_max  = 40;           % �����      (deg)
Ddelta_max = 5;            % ������ٶ�  (deg/s)
m  = 798e-5;
Iz = 39.2e-5;
xG = -0.023;
% ������������0ֵ����չ��ϵ����ֵ
Xudot  =  -42e-5;   	Yvdot =  -748e-5;   		Nvdot = 4.646e-5;
Xu    = -184e-5;   	Yrdot =-9.354e-5;   		Nrdot = -43.8e-5;
Xuu   = -110e-5;   	Yv    = -1160e-5;   	Nv    =  -264e-5;
Xuuu  = -215e-5;   	Yr    =  -499e-5;   	Nr    =  -166e-5;
Xvv   = -899e-5;   	Yvvv  = -8078e-5;   	Nvvv  =  1636e-5;
Xrr    =  18e-5;   	Yvvr  = 15356e-5;   	Nvvr  = -5483e-5;
Xdd   =  -95e-5;   	Yvu   = -1160e-5;   	Nvu   =  -264e-5;
Xudd  = -190e-5;   	Yru   =  -499e-5;   	Nru   =  -166e-5;
Xrv   =  798e-5;   	Yd    =   278e-5;   	Nd    =  -139e-5;
Xvd   =   93e-5;   	Yddd  =   -90e-5;   	Nddd  =    45e-5;
Xuvd  =   93e-5;   	Yud   =   556e-5;   	Nud   =  -278e-5;
                   	Yuud  =   278e-5;   	Nuud  =  -139e-5;
                   Yvdd  =    -4e-5;   	Nvdd  =    13e-5;
                   Yvvd  =  1190e-5;   	Nvvd  =  -489e-5;
                   Y0    =    -4e-5;   	N0    =     3e-5;
                   Y0u   =    -8e-5;   	N0u   =     6e-5;
                   Y0uu  =    -4e-5;   	N0uu  =     3e-5;
% ��ʽ(1-1)��߱���
m11 = m-Xudot;
m22 = m-Yvdot;
m23 = m*xG-Yrdot;
m32 = m*xG-Nvdot;
m33 = Iz-Nrdot;
 
% M�ļ����̿����еķ�֧�ṹ
if abs(delta_c) >= delta_max*pi/180,
% �������ö�Ǵ��ڶ���������ֵ������ö���������ֵ
   delta_c = sign(delta_c)*delta_max*pi/180; 
end
% ����ٶȵ������ڵĶ��ֵ��ȥ�ϴζ��ֵ
delta_dot = delta_c - delta;
if abs(delta_dot) >= Ddelta_max*pi/180,
% �������ö���ٶȴ��ڶ���ٶ��������ֵ������ö���ٶ��������ֵ
   delta_dot = sign(delta_dot)*Ddelta_max*pi/180;
end
 
% ��ʽ(1-2)
X = Xu*u + Xuu*u^2 + Xuuu*u^3 + Xvv*v^2 + Xrr*r^2 + Xrv*r*v + Xdd*delta^2 +...
    Xudd*u*delta^2 + Xvd*v*delta + Xuvd*u*v*delta;
Y = Yv*v + Yr*r + Yvvv*v^3 + Yvvr*v^2*r + Yvu*v*u + Yru*r*u + Yd*delta + ...
    Yddd*delta^3 + Yud*u*delta + Yuud*u^2*delta + Yvdd*v*delta^2 + ...
    Yvvd*v^2*delta + (Y0 + Y0u*u + Y0uu*u^2);
N = Nv*v + Nr*r + Nvvv*v^3 + Nvvr*v^2*r + Nvu*v*u + Nru*r*u + Nd*delta + ...
    Nddd*delta^3 + Nud*u*delta + Nuud*u^2*delta + Nvdd*v*delta^2 + ...
    Nvvd*v^2*delta + (N0 + N0u*u + N0uu*u^2);
 
detM22 = m22*m33-m23*m32;
% ��������
xdot = [           X*(U^2/L)/m11
        -(-m33*Y+m23*N)*(U^2/L)/detM22
         (-m32*Y+m22*N)*(U^2/L^2)/detM22
           (cos(psi)*(U0/U+u)-sin(psi)*v)*U
           (sin(psi)*(U0/U+u)+cos(psi)*v)*U   
                    r*(U/L)
                    delta_dot                  ];
