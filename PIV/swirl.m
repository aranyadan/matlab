function L = swirl( x,y, u,v, m )
%SWIRL Wrapper function for calculating swirling strength.


% Convert to meshgrid if necessary
if isvector(x) && isvector(y)
	[x,y] = meshgrid(x,y);
end

% Apply a simple smoothing filter
if exist('m','var') && m>1
	u = filter2( ones(m)/m^2, u );
	v = filter2( ones(m)/m^2, v );
end

% Condition the matrices
u( isnan(u) | isinf(u) ) = 0;
v( isnan(v) | isinf(v) ) = 0;

% Calculate the swirling strength
[~,L] = VortexID(x,y,u,v);

