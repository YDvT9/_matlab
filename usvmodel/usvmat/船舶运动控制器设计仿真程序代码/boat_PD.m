% ���������ļ���Ϊboat_PD
t_f = 600;   % �����¼��趨
h   = 0.1;   % ����ʱ��
Kp = 1;      % ������P����
Td = 10;     % ������D����
 
% ״̬x = [ u v r x y psi delta ]' ����ֵ
x = zeros(7,1);   
 
N = round(t_f/h);               % ������
xout = zeros(N+1,length(x)+2);    %  �����������ֵ

% ��֧�ṹ���̿���
for i=1:N+1,
    time = (i-1)*h;                   
    r   = x(3);
    psi = x(6);
    
    psi_ref = 5*(pi/180);            % ����Ŀ��Ƕ�
    delta = -Kp*((psi-psi_ref)+Td*r);  % PD������
 
    % ����M�����ļ�
    [xdot,U] = mariner(x,delta);       % ����ģ��
    
    % �洢�����Ա��������
    xout(i,:) = [time,x',U]; 
    
    % ��ֵ���֣�ŷ���㷨   
    x = x + h*xdot
end

% �Ӵ洢�������и�������ֵ
t     = xout(:,1);
u     = xout(:,2); 
v     = xout(:,3);          
r     = xout(:,4)*180/pi;   %  piΪMatlab���ⳣ������ʾԲ����
x     = xout(:,5);
y     = xout(:,6);
psi  	 = xout(:,7)*180/pi;
delta	 = xout(:,8)*180/pi;
U     = xout(:,9);
 
% ��ͼ
% ���Ҫ�����ͼ����figure(i)��i = 1��2��3������ʵ��
figure(1)
% ����ͼ֮������axis��xlabel�����ḻ�Ͷ���ͼ�ε���Ϣ
plot(y,x),grid,axis('equal'),xlabel('East'),ylabel('North'),title('Ship position')
 
figure(2)
% ���Ҫ����һ��ͼ�������Сͼ����subplot�����
subplot(221),plot(t,r),xlabel('time (s)'),title('yaw rate r (deg/s)'),grid
subplot(222),plot(t,U),xlabel('time (s)'),title('speed U (m/s)'),grid
subplot(223),plot(t,psi),xlabel('time (s)'),title('yaw angle \psi (deg)'),grid
subplot(224),plot(t,delta),xlabel('time (s)'),title('rudder angle \delta (deg)'),grid
