function output = Ylm(l,m,theta,phi);
%YLM
%
%This function returns the spherical harmonic Ylm(l,m,theta,phi). l is the
%oribtal angular momentum and m is the magnetic quantum number. theta is
%the angle from the z axis and phi is the azimuthal angle. Can except an
%array in either theta or phi, but not both.
%
%This code uses the definition from Griffiths' Quantum Mechanics Book.
%
%Tom Allison 8/10/2013

i = sqrt(-1);

if (length(theta) > 1 && length(phi) > 1) %Handle error case where arrays are put in for both theta and phi
    error('Error: Cannot put arrays for both theta and phi, this functionality is not yet supported');
elseif abs(m) > l
    error('Error: abs(m) > l');   
else
    % construct prefactor. Note that MATLAB's definition of the Legendre
    % Polynomials has a (-1)^m.
    if m >= 0
        prefactor =  sqrt( (2*l+1)/(4*pi)*factorial(l-abs(m))/factorial(l+abs(m)) );
    else 
        prefactor = (-1)^m* sqrt( (2*l+1)/(4*pi)*factorial(l-abs(m))/factorial(l+abs(m)) );
    end
    
    PlmMAT = legendre(l,cos(theta)); % this works whether theta is a scalar or an array
    output = prefactor*PlmMAT(abs(m)+1,:)*exp(i*m*phi); % use the (m+1)th row of the matrix spit out by legendre
end



