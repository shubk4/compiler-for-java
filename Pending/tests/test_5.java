class QuickSort{
    public static void main(String[] a){
	System.out.println("Start");
    }
}

class QS{
    
    int number[] ;
    int size ;
    public int Start(int sz){
	int aux01 ;
	aux01 = this.Init(sz);
	aux01 = this.Print();
	System.out.println(9999);
	aux01 = size - 1 ;
	aux01 = this.Sort(0,aux01);
	aux01 = this.Print();
	return 0 ;
    }
    public int Sort(int left, int right){
	int v ;
	int i ;
	int j ;
	int nt;
	int t ;
	boolean cont01;
	boolean cont02;
	int aux03 ;
	t = 0 ;
	if (left < right){
	    v = number[right] ;
	    i = left - 1 ;
	    j = right ;
	    cont01 = true ;
	    while (cont01){
		cont02 = true ;
		while (cont02){
		    i = i + 1 ;
		    aux03 = number[i] ;
		    if (!(aux03<v)) cont02 = false ;
		    else cont02 = true ;
		}
		cont02 = true ;
		while (cont02){
		    j = j - 1 ;
		    aux03 = number[j] ;
		    if (!(v < aux03)) cont02 = false ;
		    else cont02 = true ;
		}


		t = number[i] ;
		number[i] = number[j] ;
		number[j] = t ;
		if ( j < (i+1)) cont01 = false ;
		else cont01 = true ;
	    }
	    number[j] = number[i] ;
	    number[i] = number[right] ;
	    number[right] = t ;
	    nt = this.Sort(left,i-1);
	    nt = this.Sort(i+1,right);
	}
	else nt = 0 ;
	return 0 ;
    }

    
    // Print array of integers
    public int Print(){
	int j ;
	j = 0 ;
	while (j < (size)) {
	    j = j + 1 ;
	}
	return 0 ;
    }
    

    // Initialize array of integers
    public int Init(int sz){
	return 0 ;	
    }

}
