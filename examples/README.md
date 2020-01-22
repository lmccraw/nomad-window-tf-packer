Example Job for Windows 2016
----------------------------

## damon.nomad

This job utilizes [Jet.com's damon](https://github.com/jet/damon), a supervisor program to constrain Windows executables running under Nomad's raw_exec driver, and deploys a custom build web application that runs via an executable. The job downloads the damon.exe release and a custom webapp built in ASP.NET and executable.

*Important note*

The deployed web application is deployed on port 5000. To verify the job is working correctly go to localhost:5000

