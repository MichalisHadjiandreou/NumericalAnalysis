%The following script is used to approximate the integral of cos(7x)/e^x
%from limits of -3pi/2 to 0 using the 1/3 Simpson's rule. The purpose of
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
%subintervals to approximate the curve is 22 as 21 used before is not even
%as required by Simpson's 1/3 rule and therefore the very next even number
%is 22
%==========================================================================
%Begin by clearing the screen and the workspace
clear
clc
%Input the values of the lower and upper limit
xlower=-1.5*pi; %Your lower limit...
xupper=0; %And your upper limit...
analytical=(7*exp(3*pi/2)-1)/50; %Analytical answer
%Initially start with 21 intervals to initate the while loop
n=22; %Number of intervals...
h=(xupper-xlower)/n; %Length of inteval...
for i=0:n %Create the vector of xvalues which has length of (n+1)...
 x(i+1)=xlower+(i*h); %By keep adding h until you reach your (n+1) value
end
y=(cos(7.*x))./(exp(x)); %Obtain the yvalues for the corresponding xvalues
according to your f(x)
%Create the coefficient vector [1 4 2 4 2 ... 1]
coefficients=ones(1,(n+1)); %Initialize the vector for optimizing speed...
coefficients(2)=4; %Initialize the second value to be used later in a loop...
for i=3:n %For the rest of the values of coefficients starting from the third
one till the nth value...
 if coefficients(i-1)==4 %If the previous value is equal to 4...
 coefficients(i)=2; %Then the new value is 2...
 else
 coefficients(i)=4; %Otherwise the new value is 4
 end
end
coefficients(1)=1; %In case we choose small number of n we want to make sure
that the first and...
coefficients(n+1)=1; %Last value is still 1.
bracketsum=sum(y.*coefficients); %Multiplying all the coefficients with the
corresponding yvalues and summing them up...
I0=(h/3)*bracketsum; %And multiply the bracket sum with the corresponding
third of subinterval length to obtain the first approximation of the integral
%Having calculated the initial are we initiate a while loop that will keep
%increasing numbers of intervals, recalculate the integral and break if and
%only if a convergence of 0.01% of integrals is obtained
while 1 %Force the loop to start...
 n=n+2; %Add two more intervals to keep it even...
 h=(xupper-xlower)/n; %Length of interval updated...
 for i=0:n %Create the vector of xvalues which has length of (n+1)...
 x(i+1)=xlower+(i*h); %By keep adding h until you reach your (n+1)
value
 end
 y=(cos(7.*x))./(exp(x)); %Obtain the yvalues for the corresponding xvalues
according to your f(x)
 I1=0; %Initialize this variable to be updated later through the loop...
 %Create the coefficient vector [1 4 2 4 2 ... 1]
 coefficients=ones(1,(n+1)); %Initialize the vector for optimizing speed...
 coefficients(2)=4; %Initialize the second value to be used later in a
loop...
 for i=3:n %For the rest of the values of coefficients starting from the
third one till the nth value...
 if coefficients(i-1)==4 %If the previous value is equal to 4...
 coefficients(i)=2; %Then the new value is 2...
 else
 coefficients(i)=4; %Otherwise the new value is 4
 end
 end
 coefficients(1)=1; %In case we choose small number of n we want to make
sure that the first and...
 coefficients(n+1)=1; %Last value is still 1.
 bracketsum=sum(y.*coefficients); %Multiplying all the coefficients with
the corresponding yvalues and summing them up...
 I1=(h/3)*bracketsum; %And multiply the bracket sum with the corresponding
third of subinterval length to obtain the first approximation of the integral
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
fprintf('The value of the integral was approximated using 1/3 Simpsons rule to
be: %3.7f\n',I1)
fprintf('The above approximated value was obtained by using %i intervals of
length %2.7f and is accurate to 0.01%% from the analytical solution
%3.7f\n',n,h,analytical)
