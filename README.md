# 🛰️ AI-Based Detection of Lunar Sinuous Rilles  
_Deep Learning models and spectral image tools for automated lunar surface feature analysis using MATLAB_

---

## 🌌 Project Overview  
This project implements a **deep learning-based pipeline** for the automated detection of **sinuous rilles**-volcanic channels on the Moon-using high-resolution multispectral data from JAXA's SELENE (KAGUYA) Mission.

The pipeline includes:
- A custom MATLAB GUI for image patch creation and feature annotation  
- Deep learning models built from scratch and via transfer learning  
- Grad-CAM visualization and performance analysis tools

---

## 🚀 Highlights  
- 🌈 Custom-built application for **patch generation and manual labeling** using multispectral image data (2048×2048 pixels)  
- 🧠 Two model pipelines: **deep learning from scratch** and **transfer learning for RGB datasets**  
- 🖼️ Integrated Grad-CAM module for model interpretability  
- 📊 End-to-end prediction, validation, and testing scripts for model performance evaluation  
- 🔄 Compatible with freely available datasets from official planetary repositories  

---

## 📂 Repository Contents  

<pre>```AI-based-detection-of-Lunar-sinuous-rilles/
|
| 
├── Networks                                                # Deep Learning network files customized for training on multispectral lunar datasets 
|  ├── CustomNetwork.mlx
|  ├── MyGoogleNet.mlx
|  └── MyResNet50.mlx
|
├── goldStandardApp                                         # MATLAB App for manual annotation and patch generation from MI/DTM data 
|  └── GoldStandardApp.mlapp
|
├── readPatch.mlx / readPatchWithProcessing.mlx             # Custom preprocessing functions (also embedded in the app) 
|
├── TransferLearning_File.m / DeepLearning_File.m           # Scripts defining the model architectures and training logic 
|
├── TransferLearning_Run_File.m / DeepLearning_Run_File.m   # Launch scripts to train models (MI and RGB datasets) 
|
├── Predictions_Validation.mlx / Predictions_Testing.mlx    # Save and analyze prediction statistics from trained models 
|
├── Testing_values.mlx                                      # Apply models to isolated test sets 
|
├── gradcam_visualizations.mlx                              # Generate Grad-CAM visualizations for model explainability 
|
├── surfacePlot.mlx / viewImage.mlx                         # Visualize raw and processed images or patches 
|
├── RawData_filenames.txt                                   # Source URLs and metadata of raw datasets used 
|
├── TestImage.zip                                           # Sample dataset to reproduce and test the application 
|
└── README.md                                               # Project description and documentation```</pre>

📝 **Note**:  
- File and folder placement must remain unchanged for proper execution.  
- Many scripts prompt the user to provide dataset paths during runtime.  
- Ensure that MATLAB paths and dependencies are properly set before launching.

---

## 🧰 System Requirements

### 🔧 Hardware
- **Minimum**: Intel® Core™ i5 (8th Gen), 6 GB RAM
- **Recommended**: Intel® Core™ i7 (12th Gen), 32 GB RAM, NVIDIA® GeForce RTX™ 3080 10 GB GPU  
  (for faster training and image processing acceleration)

### 💻 Software
- **Programming Language**: MATLAB®  
- **Development Environment**: MATLAB R2023a  
- **Tested On**: MATLAB R2023b and R2024a releases  
- **Required Platform**: MATLAB® Desktop or MATLAB® Online™

### 📦 Required Toolboxes / Libraries
| Toolbox | Provider | First Release |
|--------|----------|---------------|
| Curve Fitting Toolbox™ | MathWorks | 2001 |
| Deep Learning Toolbox™ | MathWorks | 2013 |
| Image Processing Toolbox™ | MathWorks | 1994 |
| Optimization Toolbox™ | MathWorks | 1990 |
| Signal Processing Toolbox™ | MathWorks | 1987 |
| Statistics & Machine Learning Toolbox™ | MathWorks | 1992 |
| Symbolic Math Toolbox™ | MathWorks | 1997 |
| Text Analytics Toolbox™ | MathWorks | 2019 |
| Parallel Computing Toolbox™ | MathWorks | 2004 |
| MATLAB® Online™ | MathWorks | 2024 |
| Simulink® Online™ | MathWorks | 1984 |

### 📁 Program Size
Approx. **57.7 MB**

---

## 📦 Getting Started  
1. Clone the repository or download as ZIP  
2. Open MATLAB and set the root directory to the project folder  
3. For training:
   - Run `DeepLearning_Run_File.m` for MI datasets  
   - Run `TransferLearning_Run_File.m` for RGB datasets  
4. Use the `GoldStandardApp.mlapp` for patch extraction and labeling  
5. Visualize outputs using `gradcam_visualizations.mlx` or `surfacePlot.mlx`

---

## 🛰 Data Sources  
Raw multispectral and DTM image data used in this project are sourced from open-access planetary repositories. See `RawData_filenames.txt` for dataset URLs and usage rights.
Image Patches generated are publicly available. DOI: [10.34740/kaggle/dsv/8421156](https://doi.org/10.34740/kaggle/dsv/8421156)

---

## 📫 Contact  
**Dyutideepta Banerjee**  
[LinkedIn](https://www.linkedin.com/in/dyutideepta-banerjee/) | [Email](mailto:dyutideepta.banerjee@gmail.com)

---

## 📄 License  
This repository is intended for academic and non-commercial use. Data belongs to the respective public repositories cited in the documentation.

---


[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15462412.svg)](https://doi.org/10.5281/zenodo.15462412)
