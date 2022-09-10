**DAS_denoising**
======

## Description

**DAS_denoising** package is used to store the reproducible and open-access scripts for denoising the FORGE DAS dataset

## Reference
If you find this package useful, please do not forget to cite the following paper.

    Chen, Y., Savvaidis, A., Fomel, S., Chen, Y., Saad, O.M., Wang, H., Oboue, Y.A.S.I., Yang, L., & Chen, W. (2022). Denoising of distributed acoustic sensing seismic data using an integrated framework, Seismological Research Letters, 94(1), doi: 10.1785/0220220117.
    
BibTeX:
	
	@article{dasdenoising2022,
	  title={Denoising of distributed acoustic sensing seismic data using an integrated framework},
	  author={Yangkang Chen and Alexandros Savvaidis and Sergey Fomel and Yunfeng Chen and Omar M. Saad and Hang Wang and Yapo Abol{\'e} Serge Innocent Obou{\'e} and Liuqing Yang and Wei Chen},
	  journal={Seismological Research Letters},
    year=2022,
    volume=94,
    issue=1,
    pages={in press},
    doi={10.1785/0220220117},
	}

-----------
## Copyright
    Dasdenoising authors, 2021-present
-----------

## License
    GNU General Public License, Version 3
    (http://www.gnu.org/copyleft/gpl.html)   

-----------

## Install
Using the latest version

    git clone https://github.com/chenyk1990/dasdenoising
    cd dasdenoising
    addpath(genpath('./')); #in Matlab command line
    
-----------
## Examples
    The "main" directory contains all runable scripts test_figX.m to reproduce all figures in the paper.
    
-----------
## Gallery
The gallery figures of the MATdrr package can be found at
    https://github.com/chenyk1990/dasdenoising-dataonly/tree/main/gallery/
Each figure in the gallery directory corresponds to a test_figX.m script in the "main" directory with the exactly the same file name (figX.png).

-----------
## Dependence Packages
* Matlab 2015 and later versions
    
-----------
## Development
    The development team welcomes voluntary contributions from any open-source enthusiast. 
    If you want to make contribution to this project, feel free to contact the development team. 

-----------
## Contact
    Regarding any questions, bugs, developments, collaborations, please contact  
    Yangkang Chen
    chenyk2016@gmail.com

-----------
## NOTES:
 
1. To run the reproducible scripts (test_xxxx.m), please first download the required package from: https://github.com/chenyk1990/seistr. 

2. Please put the seistr package in the main directory and add its sub-directories to the Matlab toolbox path. 

3. The scripts beginning with "test_" are runnable scripts.

4. The directory subroutines stores all the required subroutines. 

5. The directory fig_bpsomffk stores all the results from the proposed denoising workflow.

6. The directory mat_raw stores all the segmented multi-channel DAS seismic data at the FORGE site. 

7. The directory mat_bpsomffk stores all the denoised DAS data. 

8. The current version is based on Matlab. Future versions will also support Python and be optimized regarding computational efficiency. 

9. All datasets used in these DEMO scripts or produced from massive processing based on this package are in a separate repository https://github.com/chenyk1990/dasdenoising-dataonly (for easier downloading). 


