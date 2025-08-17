package com.pahanaedu.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class PasswordUtilTest {

    @Test
    public void testHashAndVerify() {
        String password = "Secret123!";
        String stored = PasswordUtil.hashPassword(password);

        assertNotNull(stored, "Stored hash should not be null");
        assertTrue(stored.contains("$"), "Stored hash must contain salt and hash separated by $");
        assertTrue(PasswordUtil.verifyPassword(password, stored),
                "verifyPassword should return true for correct password");
    }

    @Test
    public void testVerifyWrongPassword() {
        String password = "Secret123!";
        String stored = PasswordUtil.hashPassword(password);

        assertFalse(PasswordUtil.verifyPassword("WrongPass", stored),
                "verifyPassword should return false for incorrect password");
    }

    @Test
    public void testSimpleHashConsistency() {
        String a = "abc";
        String b = "abc";
        String c = "def";

        String ha = PasswordUtil.simpleHash(a);
        String hb = PasswordUtil.simpleHash(b);
        String hc = PasswordUtil.simpleHash(c);

        assertEquals(ha, hb, "simpleHash should be deterministic for same input");
        assertNotEquals(ha, hc, "simpleHash should differ for different inputs");
    }
}
