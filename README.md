# A Generative Model for Axonal Ramifications - ReadME

This document provides instruction to run a generative axonal model implemented in MATLAB. 

The model creates axonal morphologies based on simple growth steps such as elongation, bifurcation and retraction and
matches statistics of biological data with high accuracy. The code was in particular developed to match
a variety of statistics of thalamocortical arborizations in cat layer 4 and 6 of area 17.

The model is described in detail in Fard Kassraian P, Pfeiffer M, Bauer R. A Generative Growth Model for Thalamocortical Axonal Branching in Primary Visual Cortex. bioRxiv. 2018 Jan 1:288522.

**XML-File with axonal data courtesy of Rodney J. Douglas, K.A.C. Martin and John Anderson, Institute of Neuroinformatics, University and ETH Zurich.**

### Prerequisites

The code was implemented with MATLAB 2016b, should however be compatible with other versions of MATLAB.
Version 6.9 of the MATLAB Parallel Computing Toolbox should be installed however to run the following code.

### Running the generative model

The model is run in two steps:

During **Step 1**, the parameters of the model are optimized with a Genetic Algorithm.
In particular, this step seeks to minimize the divergence between statistics of the generated axonal morphologies ("florets") and the biological data. 

**Step 2** employs the optimized parameters, and samples from these to generate florets and plot the results and save the relevant statistics.

### Step 1: Optimization of the model

Here, you run the optimization of the model with:

```
compute.m
```

You are prompted to set the following parameters:

* Select one of the different generator models (default is Number 3, for details see below)
* Number of Iterations of the Genetic Algorithm (default is 100)
* Number of florets to generate (default is 500). The Genetic Algorithm aims at reducing the divergence between
the segment-length and length-weighted asymmetry distribution from the biological dataset, and the distributions constructed from this number of generated florets. 

For a quick first run, chose 20 iterations of the Genetic Algorithm, and 100 florets.

### Step 2: Generating axonal morphologies and visualization

After compute.m has finished successfully, the next step is to sample from the optimized parameters to generate
axonal morphologies, and plot the results with:

```
graphs.m
```

You are prompted to set the following parameters:

* The number of solutions to plot - here, you set to generate axonal morphologies from the n best
paramter-sets optimized by the GA (e.g. 3, to sample from the 3 best solutions)
* Number of Iterations to build a Confidence Interval (default is 100)

Now, the same number of florets as selected in the compute.m step are generated, relevant plots are created and the statistics are saved in the **out** folder.

An additional function allows for **the visualization of the dendrograms**:

```
dendrogram_visualization.m
```
This functiona allows you visualize florets from either the biological or the generated data. The user
can select the visualization of all or of specific dendrograms, and the file format (fig, jpg, pdf) to save
the visualization. The respective files are saved in the ''graphs'' subfolder (for instance under 'BiologicalDendrograms'
for the biological data).

![](https://github.com/Pegahka/Florets/blob/master/Dendro.png)

### Output: Visualizations and parameters

Each run of the graphs.m files creates a timestamped folder with the name of the selected model in the "out" folder.
This folder contains the following data:

* Confidence Interval: This folder contains individual floret statistics and segment-length distributions together with the generated confidence interval.
* Convergence: This folder plots the divergence value over the successive iterations of the Genetic Algorithm.
* Optimized parameters: This folder contains the parameters optimized with the Genetic Algorithm, and the respective divergence values per Genetic algorithm generation.
* perfloret: This folder contains the individual floret statistics, such as the asymmetry value calculated per axonal morphology.
* Segment-length distribution: This folder contains visualizations of the generated segment-length distribution, calculated by taken all generated axonal morphologies into account. In addition, report.txt contains the optimized parameters for each plot.

### Details on Model Parameters

As of now, the user can chose from 8 different generative models for the creation of axonal morphologies:

* Model 1: Gamma_PL_retraction_without_offset.  
* Model 2: Gamma_PL_without_offset_without_retraction 
* **Model 3: Gamma_offset_retraction** 
* Model 4: Gamma_offset_without_retraction 
* Model 5: Gamma_retraction_without_offset 
* Model 6: Gamma_without_offset_without_retraction 
* Model 7: Normal_offset_retraction 
* Model 8: Uniform_offset_retraction 

Model 3 corresponds to the main model presented in the cited publication.

Here a brief explanation of the components of the different models:

- With or without retraction: Some models do not allow for retraction, the process where an entire segments or parts of it are removed by a randomly sampled length.
- Gamma versus normal distribution: These are the distribution from which the growth and retraction lengths at each growth or retraction step are sampled.
- With or without an offset: Models with or without a fixed first length when growth begins. This initial length is called an offset. 
- PL: Growth models with a "primitive length". Here growth and retraction lengths are not sampled from distributions, but are, similar to Galton-Watson models, a fixed length used for all generated florets.


The upper and lower bounds of these models are set in the init.mat files, in the **in** folder. You can change these bounds if you wish to optimize the parameters in a different range. Additionally you can also select which processes to include, for instance by setting the upper and lower bounds of retraction or a primitive length to 0, you have removed these options. 

Additional conditions can be set for the parameters as e.g. 2*p(bifuraction) + p(growth) < 1 which can prevent infinite growth in the case of a Galton-Watson model (primitive length = 1).



![](https://github.com/Pegahka/Florets/blob/master/Axon2.png)


