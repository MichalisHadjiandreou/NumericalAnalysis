%The following script is used to approximate the integral of cos(7x)/e^x
%from limits of -3pi/2 to 0 using the trapezoidal scheme. The purpose of
%this script is to find the minimum number of subintervals and the length
%of those subintervals until a convergence of 0.01% is achieved between
%consecutive increasing number of subintervals and output both the number
%and length of those subintervals as well as the final value of the
%integral.
%Designed by Michalis Hadjiandreou on 10th November 2017
%==========================================================================
%NOTE: Although after plotting you will realize that the function
%alternates at roots -1.5pi:pi/7:-pi/14 between positive and negative y WE DO
%NOT NEED TO WORRY ABOUT THAT because what we are asked to find is the
%integral within those limits and not the area. Therefore no consideration
%needs to be taken about the 11 roots about which our function fluctuates
%between positive and negative. However a reasonalble starting point would
%be 21 intervals to approximate it as good as possible initially
%==========================================================================
%Begin by clearing the screen and the workspace
clear
clc
%Input the values of the lower and upper limit
xlower=-1.5*pi; %Your lower limit...
xupper=0; %And your upper limit...
%Evaluate the value of y for your first point
y0=cos(7*xlower)/(exp(xlower));
analytical=(7*exp(3*pi/2)-1)/50;
%Initially start with one interval to initate the while loop
n=21; %Number of intervals...
h=(xupper-xlower)/n; %Length of inteval...
x1=xlower+h; %Value of next x which should be equal to xupper
y1=(cos(7*x1))/(exp(x1)); %Evaluate at that point the value of y
I0=(h/2)*(y0+y1); %Initial area using one interval
%Having calculated the initial integral are we initiate a while loop that will
keep
%increasing numbers of intervals, recalculate the integral and break if and
%only if a convergence of 0.01% of integrals is obtained
while 1 %Force the loop to start...
 n=n+1; %Add one more interval...
 h=(xupper-xlower)/n; %Length of interval updated...
 for i=0:n %Create the vector of xvalues which has length of (n+1)...
 x(i+1)=xlower+(i*h); %By keep adding h until you reach your (n+1)
value
 end
 y=(cos(7.*x))./(exp(x)); %Obtain the yvalues for the corresponding xvalues
according to your f(x)
 I1=0; %Initialize this variable to be updated later through the loop...
 for i=1:n %For all your intervals...
 term=(h/2)*(y(i)+y(i+1)); %Calculate the value of the small
trapezoidal area of that subinterval...
 I1=I1+term; %And add it on the total sum to give the total area(which
might be negative but that is fine because the integral is defined like that)
by the end of the loop
 end
 plot(n,I1,'.k') %Plot the iteration
 hold on
 if ((abs(analytical-I1)/analytical)*100)<=0.01 %if the absolute difference
of the approximated and analytical asnwer is less that 0.01%...
 break %Break the loop
 else
 I0=I1; %Else replace your old value with the one you just obtained and
recalculate the new area
 end
end
xlabel('Number of intervals') %Add xlabel
ylabel('Approximated integral value') %Add ylabel
%Once the loop has broken all the final values of n and h are the ones that
%satisfy the criteria, therefore we can output the results
fprintf('The value of the integral was approximated using trapezoidal scheme
to be: %3.7f\n',I1)
fprintf('The above approximated value was obtained by using %i intervals of
length %2.7f and is accurate to 0.01%% from the analytical solution
%3.7f\n',n,h,analytical)

