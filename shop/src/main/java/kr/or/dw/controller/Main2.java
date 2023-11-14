package kr.or.dw.controller;


class Test {
	int value;
	
	Test(int value){
		this.value = value;
	}
}

public class Main2 {

	public static void main(String[] args) {
		
		Test a = new Test(10);
		Test b = new Test(20);
	
		System.out.println(a);
		System.out.println(b);
		
	}
	
	static void changeByValue(Test a1 , Test b1) {
		a1.value = 100;
		a1 = b1;
	}
	

}
