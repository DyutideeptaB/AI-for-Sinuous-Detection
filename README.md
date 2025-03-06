# Codes for Artificial Intelligence based detection of lunar sinuous rilles 

The repository comprises of all MATLAB files. Below, we explain the use of every file.

1. **_Networks_** folder comprises of all the Deep Learning network files altered for our datasets.

2. **_goldStandardApp_** folder comprises of the Matlab application that can be used to produce image data of choice. The application is currently designed to read the MI data file of size 2048x2048 pixels and has provision to display either the DTM or the wavelength channel while marking the target feature. Once marked out, the size of the image patch that you want to save can be defined in appropriate box and clicking the button "save" automatically creates appropriate directories and saves the labelled data in folders.

3. **_readPatch.mlx_** and **_readPatchWithProcessing.mlx_** are variants of the specialised custom function built to read and preprocess the image data sets. A version of this function's algorithm is also embedded within the application.

4. **TransferLearning_File.m** & **DeepLearning_File.m** are the matlab scripts defining details of the training process for our needs. These are suppose to be present in the project's folder as it is but not neccesarily edited.

5. **DeepLearning_Run_File.m** & **TransferLearning_Run_File.m** are the scripts that the user needs to run to initiate the training model process. Once all the process is complete for MI dataset in Deep Learning, the user has to manually uncomment the lines for RGB type data and comment back the MI channel selection lines to do the model training. Transfer Learning is only available for RGB type dataset.

6. **Predictions_Validation.mlx** & **Predictions_Testing.mlx** are scripts to save all the prediction analysis from the various trained models. The user has to define the directory of the trained model data saves, and the script automatically creates appropriate folders/ directories to save the prediction statistics for every type of model.

7. **Testing_values.mlx** script uses an isolated test dataset to make test predictions on the trained models.

8. **gradcam_visualizations.mlx** is the basic script to conduct any gradcam analysis for trained models.

9. **surfacePlot.mlx** & viewImage are scripts to visualise the raw image data / patches.

10. **RawData_filenames.txt** is a text file that details out all the raw image data files used for this research. It also outlines the URLs for the websites these data products can be requested from. All image datasubes are available freely for use by anyone. The rights of the image remains with the providers. Please check the file for further details.

It is to be noted that the placement of the files and folders must remain as it is in order for all the scripts to run properly. Additionally, the user must appropriately define the path to the datasets in their local device for the codes to run properly. Certain scripts automatically ask the user to input the path to the dataset on running the script.
