function [ h ] = plotPIV( varargin )
%PLOTPIV plots a colormap of the listed quantities for each selected MAT
%file.
%	Valid quantities: 'u','v','urms','vrms','n','uv','vort','ss','tke'


% Which quantities should be plotted?
if nargin<1,	plist = {'u','v'};
else			plist = varargin;
end
nPlots = length(plist);

% Which data should they be plotted for?
[fs,d] = uigetfile( '.mat', 'MultiSelect', 'on' );
if ischar(fs), fs={fs}; end

% Loop through each file
nFiles = length(fs);
for n=1:nFiles
	
	ff = fullfile( d, fs{n} );
	load( ff );
	
	if exist('timestamp','var') && isa(timestamp,'measurement') && any(~cellfun(@isempty,strfind(timestamp.value,'Normalized')))
		norm = '/u_\infty';
		norm2 = 'u_\infty^2';
	else
		norm = '';
		norm2 = '';
	end
	
	% One figure per file
	h(n) = figure;
	colormap(jet);
	
	% Loop through each quantity
	for m=1:nPlots
		
		% One subfigure per quantity
		subplot( nPlots, 1, m );
		
		switch lower(plist{m})
			case {'u','um'}
				pcolor( X.value, Y.value, Um.value ); 
				title( Um.describe );
				
			case {'v','vm'}
				pcolor( X.value, Y.value, Vm.value );
				title( Vm.describe );
							
			case {'urms'}
				pcolor( X.value, Y.value, Urms.value );
				title( Urms.describe );
				
			case {'vrms'}
				pcolor( X.value, Y.value, Vrms.value );
				title( Vrms.describe );
				
			case {'n'}
				pcolor( X.value, Y.value, N.value );
				title( N.describe );
				
			case {'uv','total'}
				uv = sqrt( Um.value.^2 + Vm.value.^2 );
				pcolor( X.value, Y.value, uv );
				title([ 'Total Velocity, (u^2+v^2)' norm ]);
				clear uv;
				
			case {'vort'}
				vort = curl( X.value, Y.value, Um.value, Vm.value );
				pcolor( X.value, Y.value, vort );
				title([ 'Vorticity, \nabla\timesU' norm ]);
				clear vort;
				
			case {'ss','swirl'}
				L = swirl( X.value, Y.value, Um.value, Vm.value, 3 );
				pcolor( X.value, Y.value, L );
				title( 'Swirling Strength' );
				
			case {'tke'}
				tke = 0.5*( Urms.value.^2 + Vrms.value.^2 );
				pcolor( X.value, Y.value, tke );
				title([ 'Turbulent Kinetic Energy, (u_{rms}^2+v_{rms}^2)/2' norm2 ]);
				clear tke
		
		end
		
		shading interp;
		colorbar;
		ylabel( Y.describe );
		
	end
	
	xlabel( X.describe );
		
end