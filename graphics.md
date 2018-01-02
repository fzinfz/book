<!-- TOC -->

- [Check OpenGL, OpenCL, CUDA APIs](#check-opengl-opencl-cuda-apis)
- [OpenGL](#opengl)
    - [Libraries](#libraries)
    - [transform feedback](#transform-feedback)
- [OpenSubdiv](#opensubdiv)
- [Open Machine Learning project (OpenML)](#open-machine-learning-project-openml)
- [OpenGL Shading Language (GLSL)](#opengl-shading-language-glsl)
- [melt](#melt)
- [movit](#movit)
- [Kdenlive](#kdenlive)
- [blender](#blender)

<!-- /TOC -->

# Check OpenGL, OpenCL, CUDA APIs
Windows: http://www.ozone3d.net/gpu_caps_viewer/

# OpenGL
https://open.gl
https://github.com/Polytonic/Glitter

![](https://open.gl/media/img/c2_pipeline.png)

- vertices: the points from which shapes like triangles will later be constructed
- vertex shader： program on GPU, projects vertices with a 3D world position onto your 2D screen! passes attributes like color and texture coordinates further down the pipeline.
- geometry shader, optional

## Libraries
    SFML： cross-platform C++
    SDL：  cross-platform C
    GLFW： C，only: window and context creation and input management
    other options, like freeglut and OpenGLUT

## transform feedback
retrieve the vertices after they've passed through the vertex or geometry shaders  
NOT sent vertex data to the graphics processor and only produced drawn pixels in framebuffers in return

# OpenSubdiv
a set of open source libraries that implement high performance subdivision surface (subdiv) evaluation on massively parallel CPU and GPU architectures. 

# Open Machine Learning project (OpenML)
an inclusive movement to build an open, organized, online ecosystem for machine learning. 

# OpenGL Shading Language (GLSL)
https://en.wikipedia.org/wiki/OpenGL_Shading_Language  
created by the OpenGL ARB (OpenGL Architecture Review Board) to give developers more direct control of the graphics pipeline without having to use ARB assembly language or hardware-specific languages.

Cross-platform compatibility including GNU/Linux, macOS and Windows.  
Each hardware vendor includes the GLSL compiler in their driver, thus allowing each vendor to create code optimized for their particular graphics card’s architecture.

# melt
MLT Multimedia Framework

    melt -query # List all of the registered services

# movit
https://movit.sesse.net/

# Kdenlive
    sudo add-apt-repository ppa:kdenlive/kdenlive-stable    # GPU support
    sudo apt-get update

# blender
https://www.blender.org/  
3D pipeline—modeling, rigging, animation, simulation, rendering, compositing and motion tracking, even video editing and game creation.

https://docs.blender.org/manual/en/dev/render/cycles/gpu_rendering.html  
only support graphics cards with GCN architecture 2.0 and above)