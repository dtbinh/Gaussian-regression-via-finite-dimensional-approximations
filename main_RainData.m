% start the estimation process by defining the interesting variables
Emax				= 20;
afPotentialGammasFA	= logspace(-5,5,100);
afPotentialGammasFB	= 0;%logspace(-2,0,3);
aiPotentialEs		= [2, 4, 6, 8, 10, 12, 14, 16, 18, 20];%1:Emax;
% afPotentialGammasFA	= [1, 2];
% afPotentialGammasFB	= 0;
% aiPotentialEs		= [2, 4];
iNumberOfMCRuns		= 100;
fSpaceFactor		= 0.9999; % for adding some space at the border of the domain for avoiding border effects

% load the number of months in the database
load('../MatFiles/Data_ColoradoRain.mat');
iTotalNumberOfMonths = numel(PRECIPITATION(:,1));


for iMCRun = 1:iNumberOfMCRuns;
	%
	clc;
	fprintf('MC run %d\n', iMCRun);
	%
	iMonthForTraining = randi(iTotalNumberOfMonths);
	iMonthForSigma2 = randi(iTotalNumberOfMonths);
	%
	% get the data
	[	ffTrainingInputLocations,			...
		iiTrainingInputLocationsIndexes,	...
		afTrainingMeasurements,				...
		ffTestInputLocations,				...
		iiTestInputLocationsIndexes,		...
		afTestMeasurements	] =				...
			GetColoradoRainData(			...
				'../MatFiles/Data_ColoradoRain.mat',	...
				iMonthForTraining,						...
				0.666,									...
				tKernelParameters,						...
				0.999									);
	M		= numel(afTrainingMeasurements);
	sigma2	= EstimateVarianceOfTheColoradoRainNoise(	...
				'../MatFiles/Data_ColoradoRain.mat',	...
				iMonthForSigma2,						...
				tKernelParameters,						...
				0.999									)
	sigma2Nystrom	= EstimateVarianceOfTheColoradoRainNoise(	...
						'../MatFiles/Data_ColoradoRain.mat',	...
						iMonthForSigma2,						...
						tNystromParameters,						...
						0.999									)
	tParameters.sigma2			= sigma2; % just in case
	tKernelParameters.sigma2	= sigma2; % just in case
	tNystromParameters.sigma2	= sigma2Nystrom; % just in case
	%
	% estimate the processes
	[	fEstimatedGammaSUREFA,									...
		fEstimatedGammaOracleFA,								...
		ffEstimatedProcessSUREFA,								...
		ffEstimatedProcessOracleFA,								...
		afTrainingRSSsFA,										...
		afTrainingFitsFA,										...
		afTestRSSsFA,											...
		afTestFitsFA,											...
		afSURERisksFA,											...
		afRSSSureFA(iMCRun),									...
		afRSSOracleFA(iMCRun)		] =							...
			EstimateGammaWithDistributedSUREForFA(				...
							iiTrainingInputLocationsIndexes,	...
							afTrainingMeasurements,				...
							iiTestInputLocationsIndexes,		...
							afTestMeasurements,					...
							afPotentialGammasFA,				...
							Emax,								...
							tKernelParameters					);
	%
	% estimate the processes
	[	fEstimatedGammaSUREFANystrom,							...
		fEstimatedGammaOracleFANystrom,							...
		ffEstimatedProcessSUREFANystrom,						...
		ffEstimatedProcessOracleFANystrom,						...
		afTrainingRSSsFANystrom,								...
		afTrainingFitsFANystrom,								...
		afTestRSSsFANystrom,									...
		afTestFitsFANystrom,									...
		afSURERisksFANystrom,									...
		afRSSSureFANystrom(iMCRun),								...
		afRSSOracleFANystrom(iMCRun)		] =					...
			EstimateGammaWithDistributedSUREForFA(				...
							iiTrainingInputLocationsIndexes,	...
							afTrainingMeasurements,				...
							iiTestInputLocationsIndexes,		...
							afTestMeasurements,					...
							afPotentialGammasFA,				...
							Emax,								...
							tNystromParameters					);

	[	fEstimatedGammaSUREFB,									...
		iEstimatedESUREFB,										...
		fEstimatedGammaOracleFB,								...
		iEstimatedEOracleFB,									...
		ffEstimatedProcessSUREFB,								...
		ffEstimatedProcessOracleFB,								...
		aafTrainingRSSsFB,										...
		aafTrainingFitsFB,										...
		aafTestRSSsFB,											...
		aafTestFitsFB,											...
		aafSURERisksFB,											...
		afRSSSureFB(iMCRun),									...
		afRSSOracleFB(iMCRun)		] =							...
			EstimateGammaWithDistributedSUREForFB(				...
							iiTrainingInputLocationsIndexes,	...
							afTrainingMeasurements,				...
							iiTestInputLocationsIndexes,		...
							afTestMeasurements,					...
							afPotentialGammasFB,				...
							aiPotentialEs,						...
							tKernelParameters					);

	[	fEstimatedGammaSUREFBNystrom,							...
		iEstimatedESUREFBNystrom,								...
		fEstimatedGammaOracleFBNystrom,							...
		iEstimatedEOracleFBNystrom,								...
		ffEstimatedProcessSUREFBNystrom,						...
		ffEstimatedProcessOracleFBNystrom,						...
		aafTrainingRSSsFBNystrom,								...
		aafTrainingFitsFBNystrom,								...
		aafTestRSSsFBNystrom,									...
		aafTestFitsFBNystrom,									...
		aafSURERisksFBNystrom,									...
		afRSSSureFBNystrom(iMCRun),								...
		afRSSOracleFBNystrom(iMCRun)		] =					...
			EstimateGammaWithDistributedSUREForFB(				...
							iiTrainingInputLocationsIndexes,	...
							afTrainingMeasurements,				...
							iiTestInputLocationsIndexes,		...
							afTestMeasurements,					...
							afPotentialGammasFB,				...
							aiPotentialEs,						...
							tNystromParameters					);
	%
% 	iEstimatedEOracleFB
% 	iEstimatedESUREFB
% 	iEstimatedEOracleFBNystrom
% 	iEstimatedESUREFBNystrom
% 	afRSSOracleFB(iMCRun)
% 	afRSSSureFB(iMCRun)
% 	afRSSOracleFBNystrom(iMCRun)
% 	afRSSSureFBNystrom(iMCRun)
% 	pause
	%
end;% for over the MC runs

% [boundA, fake] = ComputeBounds(alpha, M, Emax, k, sigma2, tKernelParameters);
% [fake, boundB] = ComputeBounds(alpha, M, iEstimatedESUREFB, k, sigma2, tKernelParameters);

PlotColoradoRainResults;
ExportColoradoRainResults;
