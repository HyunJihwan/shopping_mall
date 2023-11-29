package kr.or.dw.controller;

public class Main {

	public static void main(String[] args) {
		
		String str1 = new String("String");
		
		String str2 = new String("String");
		
		String str3 = "String";
		
		String str4 = "String";
		
		System.out.println(str1 == str3);
		System.out.println(str3 == str4);
		System.out.println(str1.equals(str2));
		System.out.println(str1.equals(str3));
		
		System.out.println("----------------------");
		
		System.out.println(System.identityHashCode(str1));
		System.out.println(System.identityHashCode(str2));
		System.out.println(System.identityHashCode(str3));
		System.out.println(System.identityHashCode(str4));
		
		
		for(int i=2; i<=9; i++) {
			System.out.println(i+ "단");
			for(int j=1; j<=9; j++) {
				System.out.println(i  + "x" + j + "=" + i * j);
			}
		}
		
		

	}

}
