function [] = animateSwirl( fs, d )
%ANIMATESWIRL


% Check inputs
if ~exist( 'fs', 'var' )
	[fs d] = uigetfile( '.mat', 'MultiSelect', 'on' );
end

if ischar(fs), fs={fs}; end

%% Process the filenames
for n=1:length(fs)
	
	% Extract the frequency
	s = regexpi( fs{n}, 'ff(?<ff>[0-9]+)', 'names' );
	if isempty(s),		ff(n) = 0;
	else				ff(n) = str2double( s.ff );
	end
	
	% Extract the phase
	s = regexpi( fs{n}, 'pa(?<pa>[0-9]+)', 'names' );
	if isempty(s),		pa(n) = 0;
	else				pa(n) = str2double( s.pa );
	end
	
end

% Order the files by frequency, then by phase
[~,i] = sortrows([ ff' pa' ]);
ff = ff(i);
pa = pa(i);
fs = fs(i);

%% Create an animated GIF for each frequency
uff = unique( ff );

for n=1:length(uff)
	
	fset = find( ff == uff(n) );
	
	% FIRST FRAME
	a = load( fullfile( d, fs{fset(1)} ) );
	
	L = swirl( a.X.value, a.Y.value, a.Um.value, a.Vm.value, 3 );
	
	% Plot the swirling strength
	fh = figure; ah = axes;
	pcolor( x, y, L ); shading interp; axis image;
	c = colorbar; caxis([0 2]);
	
	% Label everything
	set(get(c,'ylabel'),'string','Swirling Strength');
	xlabel( a.X.describe ); ylabel( a.Y.describe );
	title([ 'f_F = ' num2str(uff(n)) ' Hz' ]);

	drawNACA( '0015', 15 );
	%drawVR7( 17 );
	
	set(fh,'color','w');
	set(fh,'renderer','zbuffer');
	
	annoPhase( pa(fset(1)) );
	
	frame = getframe(fh);
	[im,map] = rgb2ind(frame.cdata,256,'nodither');
	
	% REMAINING FRAMES
	for k=2:length(fset)
		
		a = load( fullfile( d, fs{fset(k)} ) );
		
		L = swirl( a.X.value, a.Y.value, a.Um.value, a.Vm.value, 3 );
		
		% Plot the swirling strength
		clf(fh); ah = axes;
		pcolor( x, y, L ); shading interp; axis image;
		c = colorbar; caxis([0 2]);
		
		% Label everything
		set(get(c,'ylabel'),'string','Swirling Strength');
		xlabel( a.X.describe ); ylabel( a.Y.describe );
		title([ 'f_F = ' num2str(uff(n)) ' Hz' ]);
		
		drawNACA( '0015', 15 );
		%drawVR7( 17 )
		
		annoPhase( pa(fset(k)) );
		
		frame = getframe(fh);
		im(:,:,1,k) = rgb2ind(frame.cdata,map,'nodither');

	end
	
	fout = fullfile( d, [ num2str(uff(n)) 'hz.gif' ] );
% 	imwrite(im,map,fout,'DelayTime',0.5,'LoopCount',Inf);
	
end