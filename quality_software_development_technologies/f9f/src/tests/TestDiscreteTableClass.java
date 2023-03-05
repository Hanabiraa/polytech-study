package tests;

import core.DiscreteTable;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class TestDiscreteTableClass {
    DiscreteTable table;
    @BeforeEach
    public void setUp() {
        String str = "a a a a ba ba bbb bbb";
        this.table = new DiscreteTable(str);
    }

    @Test
    public void testCalculateStatTable() throws NoSuchFieldException, IllegalAccessException {
        Field field = table.getClass().getDeclaredField("statTable");
        field.setAccessible(true);

        Map<Integer, Integer> statTableExpectedResult = new HashMap<>() {{
            put(1, 4);
            put(2, 2);
            put(3, 2);
        }};

        assertEquals(field.get(this.table), statTableExpectedResult, "Check stat table correct vals");
    }

    @Test
    public void testCalculateDiscreteTable() throws NoSuchFieldException, IllegalAccessException {
        Field field = table.getClass().getDeclaredField("discreteTable");
        field.setAccessible(true);

        Map<Integer, Double> discreteTableExpectedResult = new HashMap<>() {{
            put(1, 0.50);
            put(2, 0.25);
            put(3, 0.25);
        }};

        assertEquals(field.get(this.table), discreteTableExpectedResult, "Check discrete table correct vals");
    }

    @Test
    public void testCalculateMathExpectation() throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        Method method = table.getClass().getDeclaredMethod("calculateMathExpectation");
        method.setAccessible(true);

        Double expectVal = 1.75;
        assertEquals(method.invoke(this.table), expectVal);
    }

    @Test
    public void testCalculateDispersion() throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        Method method = table.getClass().getDeclaredMethod("calculateDispersion");
        method.setAccessible(true);

        Double expectVal = 0.6875;
        assertEquals(method.invoke(this.table), expectVal);
    }
}
