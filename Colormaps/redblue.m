function map = redblue(m)
%REDBLUE	A red-to-blue colormap with white at zero.


if nargin < 1
   m = size(get(gcf,'colormap'),1);
end

n = ceil(m/6);

%		Bk->Bl			Bl->Cy			Cy->Wh				Wh->Yw				Yw->Rd				Rd->Bk
r = [	zeros(n,1);		zeros(n,1);		(1:n)'/n;			ones(n,1);			ones(n,1);			((n-1):-1:0)'/n ];
g = [	zeros(n,1);		(1:n)'/n;		ones(n,1);			ones(n,1);			((n-1):-1:0)'/n;	zeros(n,1) ];
b = [	(1:n)'/n;		ones(n,1);		ones(n,1);			((n-1):-1:0)'/n;	zeros(n,1);			zeros(n,1) ];

map = [r g b];