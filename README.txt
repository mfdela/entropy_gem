= entropy-gem

This small gem provides methods to calculate the 
entropy (and cardinality and diversity) of a probability
space and of a probability metric space.

A probability space is defined by a probability
vector [p1, p2, ..., pn]. A probability metric space 
is defined by a probability vector and a metric function.
The metric function defines the "distance" between the point
i and the point j along with a distance matrix D where
D[i, j] = distance between i and j.

Most of the code is derived from:
http://golem.ph.utexas.edu/category/2008/10/entropy_diversity_and_cardinal.html
and 
http://golem.ph.utexas.edu/category/2008/11/entropy_diversity_and_cardinal_1.html

In order to define a probability space, you can use the function add_stream to
add a stream of chars (or bit). The method compute the probability
vector using the frequency of each element of the stream. Otherwise
you could supply directly a probability vector as an array of reals.

For a probability metric space you should also define the distance metric,
either passing your function as a block to define_distance, or passing
a matrix to the same define_distance.

The example files  show a basic usage of the classes.

NOTE: requires ruby >= 1.9

== Copyright

Copyright (c) 2011 hiraedd@hiraedd.com. See LICENSE.txt for further details.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

