import java.util.Map;
import java.util.Scanner;
import core.*;

public class Main {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        String row = input.nextLine();

        DiscreteTable table = new DiscreteTable(row);

        for (String table_row : table.getTable()) {
            System.out.println(table_row);
        }
    }
}