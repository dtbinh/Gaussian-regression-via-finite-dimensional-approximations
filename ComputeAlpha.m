function fAlpha = ComputeAlpha( epsilon, M, E, k )
	%
	fAlpha =								...
			E								...
		*	exp (  							...
					- ( 1 - epsilon * M )	...
					/ ( E * k )				...
				)							...
		*	epsilon^(						...
						- ( epsilon * M )	...
						/ ( E * k )			...
					);
	%
end %
