# DAS_denoising

This package is used to store the reproducible and open-access scripts for denoising the FORGE DAS dataset


If you find this package useful, please do not forget to cite the following paper. 
@Article{dasdenoising2022,
  author={Yangkang Chen and Alexandros Savvaidis and Sergey Fomel and Yunfeng Chen and Omar M. Saad and Hang Wang and Yapo Abol{\'e} Serge Innocent Obou{\'e} and Liuqing Yang and Wei Chen},
  title = {Denoising of distributed acoustic sensing seismic data},
  journal={In submission},
  year=2022,
  volume=,
  issue=,
  number=,
  pages={XXX},
  doi={},
}

NOTES: 
1. To run the reproducible scripts (test_xxxx.m), please first download the required package from: https://github.com/chenyk1990/seistr. 

2. Please put the seistr package in the main directory and add its sub-directories to the Matlab toolbox path. 

3. The scripts beginning with "test_" are runnable scripts.

4. The directory subroutines stores all the required subroutines. 

5. The directory fig_bpsomffk stores all the results from the proposed denoising workflow.

6. The directory mat_raw stores all the segmented multi-channel DAS seismic data at the FORGE site. 

7. The directory mat_bpsomffk stores all the denoised DAS data. 

8. The current version is based on Matlab. Future versions will also support Python and be optimized regarding computational efficiency. 




