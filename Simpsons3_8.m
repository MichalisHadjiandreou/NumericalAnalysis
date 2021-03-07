%The following script is used to approximate the integral of cos(7x)/e^x
%from limits of -3pi/2 to 0 using the 3/8 Simpson's rule. The purpose of
%this script is to find the minimum number of subintervals and the length
%of those subintervals until a convergence of 0.01% to the analytical
%answer is achieved and output both the number and length of those
%subintervals as well as the final value of the integral.
%Designed by Michalis Hadjiandreou on 10th November 2017
%==========================================================================
%NOTE: Although after plotting you will realize that the function
%alternates at roots -1.5pi:pi/7:-pi/14 between positive and negative y WE DO
%NOT NEED TO WORRY ABOUT THAT because what we are asked to find is the
%integral within those limits and not the area. Therefore no consideration
%needs to be taken about the 11 roots about which our function fluctuates
%between positive and negative.However a reasonlable initial number of
%subintervals to approximate the curve is 21. 20 intervals are used for
%spliting the curve from root to maximum/minimum and again back to root and
the
%final interval is for the last section from -pi/14 until zero. Furthermore
%21 is reasonable because for 3/8 Simpson's rule the number of intervals
%has to be divisible by 3. It is important to note that a simpliefied
%version of Simpson's 3/8 rule is:
%(3h/8)((y0+yn)+3(y2+y3+y5+y6+...)+2(y4+y7+...))
%==========================================================================
%Begin by clearing the screen and the workspace
clear
clc
%Input the values of the lower and upper limit
xlower=-1.5*pi; %Your lower limit...
xupper=0; %And your upper limit...
analytical=(7*exp(3*pi/2)-1)/50; %Analytical answer
%Initially start with 21 intervals to initate the while loop
n=21; %Number of intervals...
h=(xupper-xlower)/n; %Length of inteval...
for i=0:n %Create the vector of xvalues which has length of (n+1)...
 x(i+1)=xlower+(i*h); %By keep adding h until you reach your (n+1) value
end
y=(cos(7.*x))./(exp(x)); %Obtain the yvalues for the corresponding xvalues
according to your f(x)
coefficient3=0; %Initialize this variable to be updated in the for loop for
adding the yvalues that should have a coefficient of 3...
coefficient2=0; %And equally the yvalues that have coefficient of 2 according
to Simpson's rule indicated in the description
for i=2:3:(n-1) %For all values excluding the firs and last one, grouped per
interval of 4 points to follow the pattern [..3 3 2 3 3 2 3 3 2..]
 coefficient3=coefficient3+y(i)+y(i+1); %This corresponds to the previous
terms plus the periodic ones of y2 and y3...
 coefficient2=coefficient2+y(i+2); %While this one corresponds to the
previous terms plus the periodic one of y4
end
coefficient2=coefficient2-y(i+2); %Get rid of the last addition made in the
loop because the last term has coefficient of 1 and not 2 (based on the
formula in description)
I0=(3*h/8)*((y(1)+y(n+1))+(3*coefficient3)+(2*coefficient2)); %Evaluate the
integral as shown in the description and based on the previous calculations
%Having calculated the initial integral we initiate a while loop that will
keep
%increasing numbers of intervals, recalculate the integral and break if and
%only if a convergence of 0.01% of integrals is obtained
while 1 %Force the loop to start...
 n=n+3; %Add three more intervals so that they are still divisible by
three...
 h=(xupper-xlower)/n; %Length of interval updated...
 for i=0:n %Create the vector of xvalues which has length of (n+1)...
 x(i+1)=xlower+(i*h); %By keep adding h until you reach your (n+1)
value
 end
 y=(cos(7.*x))./(exp(x)); %Obtain the yvalues for the corresponding xvalues
according to your f(x)
 I1=0; %Initialize this variable to be updated later through the loop...
 coefficient3=0; %Initialize this variable to be updated in the for loop
for adding the yvalues that should have a coefficient of 3...
 coefficient2=0; %And equally the yvalues that have coefficient of 2
according to Simpson's rule indicated in the description
 for i=2:3:(n-1) %For all values excluding the first and last one, grouped
per interval of 4 points to follow the pattern [..3 3 2 3 3 2 3 3 2..]
 coefficient3=coefficient3+y(i)+y(i+1); %This corresponds to the
previous terms plus the periodic ones of y2 and y3...
 coefficient2=coefficient2+y(i+2); %While this one corresponds to the
previous terms plus the periodic one of y4
 end
 coefficient2=coefficient2-y(i+2);%Get rid of the last addition made in the
loop because the last term has coefficient of 1 and not 2 (based on the
formula in description)
 I1=(3*h/8)*((y(1)+y(n+1))+(3*coefficient3)+(2*coefficient2)); %Evaluate
the integral as shown in the description and based on the previous
calculations
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
fprintf('The value of the integral was approximated using 3/8 Simpsons rule to
be: %3.7f\n',I1)
fprintf('The above approximated value was obtained by using %i intervals of
length %2.7f and is accurate to 0.01%% from the analytical solution
%3.7f\n',n,h,analytical)
