function [ ffTrueProcess, afTrueCoefficients ] = GenerateTrueProcess( tKernelParameters )
	%
	afTrueCoefficients =									...
			randn( size(tKernelParameters.afEigenvalues) )	...
		.*	sqrt( tKernelParameters.afEigenvalues );
	%
	ffTrueProcess =											...
		GenerateSignalFromEigenfunctionsWeights(			...
			tKernelParameters,								...
			afTrueCoefficients								);
	%
end %

