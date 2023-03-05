package core;

import java.util.*;

public class DiscreteTable {
    private final Map<Integer, Integer> statTable;
    private final Map<Integer, Double> discreteTable;

    public DiscreteTable(String input_row) {
        this.statTable = calculateStatisticTable(input_row);
        this.discreteTable = calculateDiscreteTable(this.statTable);
    }

    public List<String> getTable() {
        List<String> table = new Vector<String>();

        String table_header = "Word len (Xi) |";
        String table_row = "Rand Val (Pi) |";

        for (Map.Entry<Integer, Double> entry : this.discreteTable.entrySet()) {
            table_header += String.format("\t  %s  \t|", entry.getKey());
            table_row += String.format("\t%.2f\t|", entry.getValue());
        }

        table.add(table_header);
        table.add(table_row);
        table.add(String.format("Math Expectation: %.2f", this.calculateMathExpectation()));
        table.add(String.format("Dispersion: %.2f", this.calculateDispersion()));
        return table;
    }

    private Map<Integer, Integer> calculateStatisticTable(String row) {
        Map<Integer, Integer> table = new HashMap<Integer, Integer>();

        for (String token : row.split("\\s+")) {
            Integer token_len = token.length();
            if (table.containsKey(token_len)) {
                table.merge(token_len, 1, Integer::sum);
            } else {
                table.put(token_len, 1);
            }
        }
        return table;
    }

    private Map<Integer, Double> calculateDiscreteTable(Map<Integer, Integer> stat_table) {
        Map<Integer, Double> discreteTable = new HashMap<Integer, Double>();
        Integer token_count = statTable.values().stream().reduce(0, Integer::sum);

        for (Map.Entry<Integer, Integer> entry : this.statTable.entrySet()) {
            discreteTable.put(entry.getKey(), entry.getValue().doubleValue() / token_count);
        }

        return discreteTable;
    }

    private Double calculateMathExpectation() {
        // sum(Xi * Pi)
        return this.discreteTable.entrySet().stream().mapToDouble(e -> e.getKey().floatValue() * e.getValue()).sum();
    }

    private Double calculateDispersion() {
        // sum(Xi^2 * Pi) - sum(Xi * Pi)^2
        Double mathExpectSquare = this.discreteTable.entrySet()
                .stream()
                .mapToDouble(e -> Math.pow(e.getKey().floatValue(), 2) * e.getValue())
                .sum();
        return mathExpectSquare - Math.pow(this.calculateMathExpectation(), 2);
    }
}
