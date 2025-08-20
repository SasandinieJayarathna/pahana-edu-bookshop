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

    @Test
    public void testVerifyMalformedStoredHash() {
        // should return false and not throw
        assertFalse(PasswordUtil.verifyPassword("pw", "not-a-valid-format"));
    }

    @Test
    public void testHashProducesDifferentSaltedHashes() {
        String pw = "SamePassword";
        String s1 = PasswordUtil.hashPassword(pw);
        String s2 = PasswordUtil.hashPassword(pw);
        // salted hashes should not be identical because salt differs
        assertNotEquals(s1, s2);
    }

    @Test
    public void testSimpleHashEmptyString() {
        String h = PasswordUtil.simpleHash("");
        assertNotNull(h);
        assertFalse(h.isEmpty());
    }

    @Test
    public void testSimpleHashLengthConsistent() {
        String a = PasswordUtil.simpleHash("a");
        String longS = PasswordUtil.simpleHash("this is a much longer password string");
        // SHA-256 hex length is 64 characters
        assertEquals(64, a.length());
        assertEquals(64, longS.length());
    }

    @Test
    public void testHashPasswordReturnsSaltAndHash() {
        String stored = PasswordUtil.hashPassword("pw");
        String[] parts = stored.split("\\$");
        assertEquals(2, parts.length);
        assertEquals(32, parts[0].length()); // 16 bytes salt -> 32 hex chars
        assertEquals(64, parts[1].length()); // SHA-256 hash hex length
    }

    @Test
    public void testVerifyNullPasswordOrStored() {
        assertFalse(PasswordUtil.verifyPassword(null, null));
        assertFalse(PasswordUtil.verifyPassword(null, "abc$def"));
        assertFalse(PasswordUtil.verifyPassword("pw", null));
    }
}
