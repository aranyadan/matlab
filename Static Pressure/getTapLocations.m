function [ xc closed unused H ] = getTapLocations( airfoil )
% Returns the normalized tap locations for the specified airfoil.


switch lower(airfoil)
%	case { 'airfoil name' }
%		chord	= chord length [in]
%		xc		= x/c tap locations
%		H		= surface-normal tap angles at zero angle of attack [deg]
%		closed	= should the pressure contour be closed?
%		unused	= list of unused pressure transducers

	case { 'a1', 'naca0015-smooth' }
		chord	= 8;
		xc		= [0 0.04 0.08 0.12 0.16 0.32 0.48 0.64 0.8 1.2 1.6 2.4 3.2 4 4.8 5.6 6.4 7.2 8 7.2 6.4 5.6 4.8 4 3.2 1.6 1.2 0.8 0.64 0.48 0.32 0.16 0.12 0.08 0.04]/chord;
		H		= [];
		closed	= true;
		unused	= [ 26:32, 43:48 ];

	case { 'a2', 'naca0015-recess' }
		chord	= 8;
		xc		= [0 0.04 0.08 0.12 0.16 0.32 0.48 0.64 0.8 1.2 1.6 2.4 3.2 4 4.8 5.6 6.4 7.2 8 7.2 6.4 5.6 4.8 4 3.2 1.6 1.2 0.85 0.64 0.48 0.32 0.16 0.12 0.08 0.04]/chord;
		H		= [3.14159265358979,2.54673870866764,2.36316527115416,2.24985456260599,2.16984802404605,1.98721394784817,1.89024552882753,1.82611289516531,1.77878881276619,1.69741799906513,1.64283412652085,1.57059747627131,1.52392681439863,1.49134074169593,1.46716363016825,1.44769685055751,1.43009564284410,1.41194909325883,3.88578058618805e-16,-1.41194909325883,-1.43009564284410,-1.44769685055751,-1.46716363016825,-1.49134074169593,-1.52392681439863,-1.64283412652085,-1.69741799906513,-1.77878881276619,-1.82611289516531,-1.89024552882753,-1.98721394784817,-2.16984802404605,-2.24985456260599,-2.36316527115416,-2.54673870866764];
		closed	= false;
		unused	= [ 26:32, 43:48 ];

	case { 'a3', 'boeing-vr7' }
		chord	= 7.96;
		xc		= [0.00 0.08 0.13 0.21 0.31 0.47 0.66 0.78 1.09 1.55 2.26 3.21 4.81 5.46 6.44 7.25 7.60 7.60 7.25 6.45 5.49 4.85 3.88 3.24 2.28 1.58 1.08 0.75 0.65 0.44 0.30 0.13 0.05 0.02]/chord;
        H		= [3.14159265358979,2.31705249885469,2.22333015919952,2.12130342009291,2.03480456006182,1.95600754163975,1.89110066061288,1.85660600313421,1.78455084500605,1.71467017533635,1.60471350957734,1.51715866220051,1.40894005232501,1.40651616342423,1.40694835208762,1.40675063854885,1.40619585144887,-1.51974678613243,-1.51982192896689,-1.52023998711354,-1.51956402295258,-1.51948895106713,-1.52840299311579,-1.55365093709155,-1.58292637456854,-1.59927239089158,-1.62928823305444,-1.66310302952686,-1.69092868760791,-1.69692841379970,-1.71695602061291,-1.82161273239069,-2.06465602448469,-2.44008665811829];
		closed	= false;
		unused	= [ 35:48 ];

end