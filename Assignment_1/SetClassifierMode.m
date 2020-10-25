function mode = SetClassifierMode()
prompt= 'Select Classifier mode between Normal or Laplace.\n';
mode = input(prompt,'s');
if (mode ~= "Normal" && mode ~= "Laplace")
    disp('Invalid mode')
    return
end
end