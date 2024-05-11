import java.util.*;
import java.sql.*;
class eventhandling {
    public static void main(String[] args)throws Exception {
        Scanner sc = new Scanner(System.in);
        String driverName = "com.mysql.cj.jdbc.Driver";

        Class.forName(driverName);
        String dburl = "jdbc:mysql://localhost:3306/event";
        String dbuser = "root";
        String dbpass = "";
        Connection con = DriverManager.getConnection(dburl,dbuser,dbpass);
        if(con!=null)
        {
            System.out.println("Connection Successfull");
        }
        else
        {
            System.out.println("Connection Failed");
        }
        int choice;
        do{

            // sc.nextLine();
            System.out.println(" 1.INSERT \n 2.DELETE \n 3.UPDATE \n 4.SHOW ALL EVENTS \n 5.QUIT");
            choice=sc.nextInt();
            switch(choice)
            {
              case 1:
                {
                    System.out.println("------ INSERTING NEW EVENTS ------");
                    System.out.println("How many events you want to add");
                    int n=sc.nextInt();                    
                    // sc.nextLine();

                    for(int i=1;i<=n;i++)
                    {
                    System.out.println("Event details :"+i);
                    System.out.println("Enter ename: ");
                    sc.nextLine();
                    String name=sc.nextLine();
                    System.out.println("Enter price: ");
                    int price=sc.nextInt();
                    System.out.println("Enter total number of seats: ");
                    Long seats=sc.nextLong();
                    System.out.println("Enter category of event: ");
                    String category=sc.next();
                    //add venue and time column
                    String sql1="insert into eventdetails(ename,eprice,eseats,ecategory)values(?,?,?,?)";
                    PreparedStatement pst=con.prepareStatement(sql1);
                    pst.setString(1,name);
                    pst.setInt(2, price);
                    pst.setLong(3,seats);
                    pst.setString(4,category);
                    int r=pst.executeUpdate();
                    if(r>0)
                    {
                        System.out.println("INSERTED");
                    }
                    else
                    {
                        System.out.println("NOT INSERTED");
                    }
                    }
                    System.out.println("------ ALL EVENTS ADDED ------ ");
                    break;
                }
                case 2:
                {
                    System.out.println("------ DELETING EVENT ------");
                    System.out.println("Enter event id you want to delete: ");
                    int del=sc.nextInt();
                
                    String sql2="delete from eventdetails where eid=?";
                    PreparedStatement pst=con.prepareStatement(sql2);
                    pst.setInt(1,del);
                    
                    int r=pst.executeUpdate();

                    if(r>0){System.out.println("------ EVENT DELETED ------");}
                    else{System.out.println("------ NO EVENT FOUND ------");}
                    break;
                }
                case 3:
                {
                    System.out.println("------ UPDATE EVENT ------");
                    System.out.println("Enter event name you want to update: ");
                    sc.nextLine();
                    String update=sc.nextLine();

                    System.out.println("Enter new price: ");
                    int price=sc.nextInt();

                    System.out.println("How many seats you wish to add: ");
                    Long seat=sc.nextLong();

                    String sql3="{call updateevent(?,?,?)}";
                    CallableStatement cst=con.prepareCall(sql3);
                    cst.setInt(1,price);
                    cst.setLong(2,seat);
                    cst.setString(3,update);
                    cst.execute();
                    cst.close();
                    System.out.println("------ UPDATED ------");
                    break;
                }
                case 4:{
                    System.out.println("------ EVENT DETAILS ------");
                    String sql4="select * from eventdetails";
                    PreparedStatement pst=con.prepareStatement(sql4);

                    ResultSet rs=pst.executeQuery();

                    while(rs.next())
                    {
                        System.out.println();
                        System.out.println(rs.getInt(1)+".");
                        System.out.println("Name: "+rs.getString(2));
                        System.out.println("Price: "+rs.getInt(3));
                        System.out.println("Seats:"+rs.getLong(4));
                        System.out.println("Category: "+rs.getString(5));
                    }
                    System.out.println("-------------------");
                    break;
                }
                case 5:{ System.out.println("------ YOU ARE EXITING ------");break;}

                default:
                {
                    System.out.println("------ Enter valid choice ------");break;
                }
            }
        
        }while(choice!=5);
}
}