explore the Julia set from javascript!


this projects draws the Julia  set in the complex plain and allows you to 
interact with it
zoom on a determinate position just doing click where you want.



IMPORTANT : the main.js is using workers, 
that means that in exchange of a relative quick charge,
 the use of cpu
will grow and go to 99%~100%, be carefull with the temp of your cpu!
 *in a few months i will try to fix this*

if you don't want or can't use the example with workers, 
just change in the html the import for main.js to main2.js, 
this  one doesn't 
use workers.

Also to use the workers,
 you have to execute first the python file within this folder,
 it will create a local server, to allow that comunication
between the workers and the main process.

python 3 is required