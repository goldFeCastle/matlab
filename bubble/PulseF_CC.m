function Data =PulseF_CC(dt,R0,Pm,Cycle,r, Rho, c0, f)

T=1/4E+6; CycleT=T*Cycle;
t=0:dt:CycleT+dt; % time vector

% Extra condition 
Pa = Pm*sin(2*pi*f*t);
R=[]; dR=[]; d2R=[]; H=[];
R(1)=R0; dR(1)=0; % Initial condition
N=(CycleT+dt)/dt;

% SonoVue parameter
Gamma = 1.07;       % The surface tension
Sigma = 0.051;      % The polytropic gas exponent
u = 0.4;            % Shear viscosity
n = 7;              % Water ratio of heat capacibity
P0 = 101300;        % The ambient pressure of the surronding liquid
A = ((c0)^2)*Rho/n;  
B = A - P0;




rr = r;

for i=1:N
    %Pg = (P0 + 2*Sigma/R(i))*((R0/R(i))^(3*Gamma)); % Pressure of the gas inside the bubble
    %Pb = Pg-(2*Sigma/R(i))-(4*u*((dR(i))^2)/R(i)); % Pressure at the bubble wall
   % Runge-Kutta 6th order  1.1785E3
    % Point1
    h1=(n/(n-1))*((A^(1/n))/Rho)*(((P0+(2*Sigma/R(i)))*((R0/R(i))^(3*Gamma))-(4*u*((dR(i))^2)/R(i))-(2*Sigma/R(i))+B)^((n-1)/n)-(P0+5E2+B)^((n-1)/n));
    c1=((c0^2)+(n-1)*h1)^(0.5); % Speed of sound
    Zeta1=((1+(dR(i)/c1))*h1-1.5*(1-(dR(i)/(3*c1)))*(dR(i)*dR(i)))/(R(i)*(1-(dR(i)/c1)));
    Alpha1=((P0+(2*Sigma/R0))*((R0/R(i))^(3*Gamma))-(2*Sigma/R(i))-(4*u*((dR(i))^2)/R(i))+B)^(-1/n);
    Beta1=(-2*Sigma/(R(i)*R(i)))*((R0/R(i))^(3*Gamma))-3*Gamma*((P0+(2*Sigma/R(i)))*((R0/R(i))^(3*Gamma)))*(1/R(i))+(2*Sigma/(R(i)*R(i)))+4*u*(dR(i)*dR(i)/(R(i)*R(i)));
    d2R1= (Zeta1+(dR(i)/c1)*((A^(1/n))/(Rho))*Alpha1*Beta1)/(1+8*u*((A^(1/n))/(Rho))*Alpha1*dR(i)/(c1*R(i))); % Acceleration of Radius
    
    R2=R(i)+(dR(i)*(dt/4));
    dR2=dR(i)+(d2R1*(dt/4));
   
    % Point 2
    h2=((n/(n-1))*(A^(1/n))/Rho)*((((P0+(2*Sigma/R2))*((R0/R2)^(3*Gamma))-(4*u*((dR2)^2)/R2)-(2*Sigma/R2)+B)^((n-1)/n))-(P0+5E2+B)^((n-1)/n)); %Enthalpy
    c2=((c0^2)+(n-1)*h2)^(0.5); % Speed of sound
    Zeta2=((1+(dR2/c2))*h2-1.5*(1-(dR2/(3*c2)))*(dR2*dR2))/(R2*(1-(dR2/c2)));
    Alpha2=((P0 + (2*Sigma/R0))*((R0/R2)^(3*Gamma))-(2*Sigma/R2)-(4*u*((dR2)^2)/R2)+B)^(-1/n);
    Beta2=(-2*Sigma/(R2*R2))*((R0/R2)^(3*Gamma))-3*Gamma*((P0 + (2*Sigma/R2))*((R0/R2)^(3*Gamma)))*(1/R2)+(2*Sigma/(R2*R2))+4*u*((dR2*dR2)/(R2*R2));
    d2R2=(Zeta2+(dR2/c2)*((A^(1/n))/(Rho))*Alpha2*Beta2)/(1+8*u*((A^(1/n))/(Rho))*Alpha2*dR2/(c2*R2));% Acceleration of Radius
    
    R3=R(i)+(3/32)*(dR(i)+3*dR2)*dt;
    dR3=dR(i)+(3/32)*(d2R1+3*d2R2)*dt;
    
    %Point 3
    h3=((n/(n-1))*(A^(1/n))/Rho)*(((P0+(2*Sigma/R3))*((R0/R3)^(3*Gamma))-(4*u*((dR3)^2)/R3)-(2*Sigma/R3)+B)^((n-1)/n)-(P0+5E2+B)^((n-1)/n)); %Enthalpy
    c3=((c0^2)+(n-1)*h3)^(0.5); % Speed of sound
    Zeta3=((1+(dR3/c3))*h3-1.5*(1-(dR3/(3*c3)))*(dR3*dR3))/(R3*(1-(dR3/c3)));
    Alpha3=((P0+(2*Sigma/R0))*((R0/R3)^(3*Gamma))-(2*Sigma/R3)-4*u*(((dR3)^2)/R3)+B)^(-1/n);
    Beta3=(-2*Sigma/(R3*R3))*((R0/R3)^(3*Gamma))-3*Gamma*(P0+(2*Sigma/R3))*((R0/R3)^(3*Gamma))*(1/R3)+(2*Sigma/(R3*R3))+4*u*((dR3*dR3)/(R3*R3));
    d2R3=(Zeta3+(dR3/c3)*((A^(1/n))/(Rho))*Alpha3*Beta3)/(1+4*u*((A^(1/n))/(Rho))*Alpha3/(c3*R3));% Acceleration of Radius
    
    R4=R(i)+(12/2197)*(161*dR(i)-600*dR2+608*dR3)*dt ;
    dR4=dR(i)+(12/2197)*(161*d2R1-600*d2R2+608*d2R3)*dt;
    
    % Point 4
    h4=((n/(n-1))*(A^(1/n))/Rho)*(((P0+(2*Sigma/R4))*((R0/R4)^(3*Gamma))-(4*u*((dR4)^2)/R4)-(2*Sigma/R4)+B)^((n-1)/n)-(P0+5E2+B)^((n-1)/n)); %Enthalpy
    c4=((c0^2)+(n-1)*h4)^(0.5); % Speed of sound
    Zeta4=((1+(dR4/c4))*h4-1.5*(1-(dR4/(3*c4)))*(dR4*dR4))/(R4*(1-(dR4/c4)));
    Alpha4=((P0+(2*Sigma/R0))*((R0/R4)^(3*Gamma))-(2*Sigma/R4)-4*u*(((dR4)^2)/R4)+B)^(-1/n);
    Beta4=(-2*Sigma/(R4*R4))*((R0/R4)^(3*Gamma))-3*Gamma*(P0+(2*Sigma/R4))*((R0/R4)^(3*Gamma))*(1/R4)+(2*Sigma/(R4*R4))+4*u*((dR4*dR4)/(R4*R4));
    d2R4=(Zeta4+(dR4/c4)*((A^(1/n))/(Rho))*Alpha4*Beta4)/(1+8*u*((A^(1/n))/(Rho))*Alpha4*dR4/(c4*R4));% Acceleration of Radius
    
    R5=R(i)+(1/4104)*(8341*dR(i)-32832*dR2+29440*dR3-845*dR4)*dt;
    dR5=dR(i)+(1/4104)*(8341*d2R1-32832*d2R2+29440*d2R3-845*d2R4)*dt;
    
    % Point 5
    h5=((n/(n-1))*(A^(1/n))/Rho)*(((P0+(2*Sigma/R5))*((R0/R5)^(3*Gamma))-(4*u*((dR5)^2)/R5)-(2*Sigma/R5)+B)^((n-1)/n)-(P0+5E2+B)^((n-1)/n)); %Enthalpy
    c5=((c0^2)+(n-1)*h5)^(0.5); % Speed of sound
    Zeta5=((1+(dR5/c5))*h5-1.5*(1-(dR5/(3*c5)))*(dR5*dR5))/(R5*(1-(dR5/c5)));
    Alpha5=((P0+(2*Sigma/R0))*((R0/R5)^(3*Gamma))-(2*Sigma/R5)-4*u*(((dR5)^2)/R5)+B)^(-1/n);
    Beta5=(-2*Sigma/(R5*R5))*((R0/R5)^(3*Gamma))-3*Gamma*(P0+(2*Sigma/R5))*((R0/R5)^(3*Gamma))*(1/R5)+(2*Sigma/(R5*R5))+4*u*((dR5*dR5)/(R5*R5));
    d2R5=(Zeta5+(dR5/c5)*((A^(1/n))/(Rho))*Alpha5*Beta5)/(1+8*u*((A^(1/n))/(Rho))*Alpha5*dR5/(c5*R5));% Acceleration of Radius
    
    R6=R(i)+(-(8/27)*dR(i)+2*dR2-(3544/2565)*dR3+(1859/4104)*dR4-(11/40)*dR5)*dt;
    dR6=dR(i)+(-(8/27)*d2R1+2*d2R2-(3544/2565)*d2R3+(1859/4104)*d2R4-(11/40)*d2R5)*dt;
   
    % Point 6
    h6=((n/(n-1))*(A^(1/n))/Rho)*(((P0+(2*Sigma/R6))*((R0/R6)^(3*Gamma))-(4*u*((dR6)^2)/R6)-(2*Sigma/R6)+B)^((n-1)/n)-(P0+5E2+B)^((n-1)/n)); %Enthalpy
    c6=((c0^2)+(n-1)*h6)^(0.5); % Speed of sound
    Zeta6=((1+(dR6/c6))*h6-1.5*(1-(dR6/(3*c6)))*(dR6*dR6))/(R6*(1-(dR6/c6)));
    Alpha6=((P0+(2*Sigma/R0))*((R0/R6)^(3*Gamma))-(2*Sigma/R6)-4*u*(((dR6)^2)/R6)+B)^(-1/n);
    Beta6=(-2*Sigma/(R6*R6))*((R0/R6)^(3*Gamma))-3*Gamma*(P0+(2*Sigma/R6))*((R0/R6)^(3*Gamma))*(1/R6)+(2*Sigma/(R6*R6))+4*u*((dR6*dR6)/(R6*R6));
    d2R6=(Zeta6+(dR6/c6)*((A^(1/n))/(Rho))*Alpha6*Beta6)/(1+8*u*((A^(1/n))/(Rho))*Alpha6*dR6/(c6*R6));% Acceleration of Radius
    
         
    k=(1/5)*((16/27)*dR(i)+(6656/2565)*dR3+(28561/11286)*dR4-(9/10)*dR5+(2/11)*dR6);
    kdot= (1/5)*((16/27)*d2R1+(6656/2565)*d2R3+(28561/11286)*d2R4-(9/10)*d2R5+(2/11)*d2R6);
    
    r=R(i) + k*dt;
    dr=dR(i) + kdot*dt;     
    
    R=[R r]; dR=[dR dr]; d2R=[d2R d2R1]; H=[H h1];
    
end

H=[H 0];

t=0:dt:dt*(length(R)-1);
Ps=[];

for i=1:length(R)
G=R(i)*(H(i)+((dR(i)*dR(i))/2));
cl=((c0^2)+(n-1)*H(i))^(0.5);
ps=A*((((2/(n+1))+((n-1)/(n+1))*((1+((n+1)*G/(rr*((cl)^2))))^(1/2))))^(2*n/(n-1)))-B-P0;
Ps=[Ps ps];
end
Rmin=min(R); Hmax=max(H); Umax=max(dR); 
Gmax=Rmin*(Hmax+0.5*Umax*Umax);

dx=(2E-3)/N;
x=-1E-3:dx:1E-3;
Pr=[];
for i=1:length(R)
    pr=A*(((2/(n+1))+((n-1)/(n+1))*(1+(n+1)*Gmax/(((x(i)^2+rr^2)^(0.5))*c0))^(0.5)))^(2*n/(n-1))-B-P0;
    Pr=[Pr pr];
end

Ps=abs(Ps);
Pa=abs(Pa);

Data=[t',Ps',Pr'];