function neuralPatternRecognition(inputs,targets, hiddenLayerSize, labelName)
    %Solve a Pattern Recognition Problem with a Neural Network

    % Bayesian regularization backpropagation.
    trainFcn = 'trainbr';  
    %trainFcn = 'trainscg';  

    % Create a Pattern Recognition Network
    net = patternnet(hiddenLayerSize, trainFcn);


    % Set up Division of Data for Training, Validation, Testing
    net.divideFcn = 'dividerand'; 
    net.divideMode = 'sample'; 
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

    net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
        'plotconfusion', 'plotroc'};

    % Train the Network
    [net,tr] = train(net,inputs,targets);

    % Test the Network
    outputs = net(inputs);
    errors = gsubtract(targets,outputs);
    performance = perform(net,targets,outputs);

    % View the Network
    %view(net)

    % Plots
    figure, plotperform(tr)
    figure, plottrainstate(tr)
    figure;
    plotconfusion(targets,outputs);
    title(sprintf("%s - Confusion matrix with %d hidden layers", labelName, hiddenLayerSize));
end