% Parameter definition
res=[51,51];
pop_size=100;
fertility=round(pop_size/2);
n_iter=500;
pop=exp(1i*2*pi*rand(res(1),res(2),pop_size));
R0=0.2;
Rend=0.01;
decay_factor=30;
% Transfer function of forward model
kx=linspace(-0.5,0.5,res(1));
ky=linspace(-0.5,0.5,res(2));
[Kx,Ky]=meshgrid(kx,ky);
Kr=sqrt(Kx.^2+Ky.^2);
tf=(rand(res(1),res(2))*0.5+0.5).*exp(1i*2*pi*rand(res(1),res(2)));
tf_radius=0.1;
tf=tf.*(Kr<tf_radius);
% Generate target of forward model
% target=Kr<0.2;
target=exp(-(Kr/0.1).^2);
% Create function handle to pass on
comp_cost_handle=@(pop) comp_cost_sim(pop,tf,target);
mutate_handle=@(pop,R) mutate_sim( pop,R );
[ out ] = goa_2d( pop_size,comp_cost_handle,mutate_handle,fertility,n_iter,pop,R0,Rend,decay_factor);
disp('Done!');