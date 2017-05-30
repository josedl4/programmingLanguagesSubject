import java.util.Scanner;

/*¿El analizador sintactico debe comprobar que el nombre de la clase y el archivo coincidan?*/
public class test{
  public static void main(String[] args){
    /*  Este comentario debería ser ignorado
    * public int funcionInexistente(){}
    */
    int v1;
    v1=1;
    int v2=2;
    float v3;
    func1();
    v3 =func3(v1,v2);
    Scanner s=func4();
    s.close();
    System.out.println("A ver si cuela \n public void funcErronea(); \n");

  }

  private static void func1(){}
  //funcion con modificadores y sin cuerpo
  public native int func2();
  //otra funcion con mas modificadores
  protected static strictfp float func3(int v1, int v2){
    float result=(float)(v1+ v2);
    return result;
  }
  //funcion que devuelve un objeto
  public static  Scanner func4(){
    Scanner s= new Scanner(System.in);
    return s;
  }

}
