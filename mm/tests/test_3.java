class Factorial{
    public void main(String[] a){
	// new Fac().ComputeFac(10);
    }
}

class Fac {

    public int ComputeFac(int num){
    int num_aux ;
    num_aux_undefined = 1;
	if (num < 1)
	    num_aux = 1 ;
	else 
	    num_aux = num * (this.ComputeFac(num-1)) ;
	return num_aux ;
    }

}
