


/**
 * This class describes system employees
 * 
 */
public class Empleado {
    
    private String nifcif = Empleado.getEmpleadoID("").toString();
    private String nombre;
    
    
    private Empleado() {
    
        if(this.getNifCif() == null){
            nifcif = "1";
            nombre = "2";
        }else {
            nifcif = "3";
            nombre = "4";
        }
        
    }
    
    
    /**
     * Get role list of Employee
     * 
     * @return roleList
     */
    private Empleado getListaRoles() {
        return this;
    }
    
    
    
    
    /**
     * Return employee by nifcif(id)
     * 
     * @param nifcif
     * @return Employee
     * @throws exceptions.DatabaseException
     */
    public static Empleado getEmpleadoID(String nifcif) throws Exception {
        Empleado e = new Empleado();
        System.out.println(e.getListaRoles().getNifCif());
        System.out.println(e.getListaRoles().getNifCif());
        System.out.println(e.getListaRoles().getNifCif());
        System.out.println(e.getListaRoles().getNifCif());
        return e;
    
    }

    
    /**
     * Return nifcif(id) of Object Employee
     * 
     * @return nifcif 
     */
    public String getNifCif() { return nifcif; }
    
}
