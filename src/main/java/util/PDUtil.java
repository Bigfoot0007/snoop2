package util;

import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.util.Hashtable;
import java.util.StringTokenizer;

import org.apache.commons.codec.binary.Base64;

import com.tivoli.pd.jasn1.PDPointer;
import com.tivoli.pd.jasn1.PDUTF8String;
import com.tivoli.pd.jasn1.PDVector;
import com.tivoli.pd.jasn1.attr_t;
import com.tivoli.pd.jasn1.attrlist_t;
import com.tivoli.pd.jasn1.ivprincipal_chain_t;
import com.tivoli.pd.jasn1.ivprincipal_t;
import com.tivoli.pd.jasn1.value_t;
import com.tivoli.pd.jutil.PDException;

public class PDUtil {

	public void decodeAndDump(String ivCred) throws PDException,
			ClassNotFoundException, NoClassDefFoundError {
		Hashtable<String, Object> result = decodeCred(ivCred);
		for (Object key : result.keySet()) {
			Object v = result.get(key);
			if (v instanceof String[]) {
				for (int i = 0; i < ((String[]) v).length; i++) {
					System.out.println(String.format("%s[%s]: %s", key, i,
							((String[]) v)[i]));
				}
			} else {
				System.out
						.println(String.format("%s: %s", key, result.get(key)));
			}
		}
	}

	public static Hashtable<String, Object> decodeCred(String paramString)
			throws PDException, ClassNotFoundException, NoClassDefFoundError {
		paramString = parseInput(paramString);
		byte[] arrayOfByte1 = getBytes(paramString);

		byte[] arrayOfByte2 = null;

		ByteArrayInputStream localByteArrayInputStream = new ByteArrayInputStream(
				arrayOfByte1);
		arrayOfByte2 = Base64.decodeBase64(arrayOfByte1);

		localByteArrayInputStream = new ByteArrayInputStream(arrayOfByte2);
		ivprincipal_chain_t localivprincipal_chain_t = new ivprincipal_chain_t();
		localivprincipal_chain_t.decode(localByteArrayInputStream);

		PDVector localPDVector1 = localivprincipal_chain_t.principal_list();
		ivprincipal_t localivprincipal_t = (ivprincipal_t) localPDVector1
				.get(0);
		PDPointer localPDPointer = localivprincipal_t.attrs();
		attrlist_t localattrlist_t = (attrlist_t) localPDPointer.getObj();
		PDVector localPDVector2 = localattrlist_t.attr_list();

		Hashtable<String, Object> localHashtable = new Hashtable<String, Object>();
		for (int i = 0; i < localPDVector2.length(); ++i) {
			Object localObject1;
			Object localObject2;
			attr_t localattr_t = (attr_t) localPDVector2.get(i);
			PDUTF8String localPDUTF8String1 = localattr_t.attr_name();
			String str1 = localPDUTF8String1.getVal();
			PDVector localPDVector3 = localattr_t.value_list();

			int j = localPDVector3.length();

			if ((j == 1) && (str1 != null)
					&& (!(str1.equals("AZN_CRED_GROUP_REGISTRY_IDS")))
					&& (!(str1.equals("AZN_CRED_GROUPS_NAMES")))
					&& (!(str1.equals("AZN_CRED_GROUPS")))) {
				localObject1 = (value_t) localPDVector3.get(0);
				PDUTF8String localPDUTF8String2 = ((value_t) localObject1)
						.utf8val();
				localObject2 = localPDUTF8String2.getVal();
				localHashtable.put(str1, localObject2);
			} else if (str1 != null) {
				localObject1 = new String[j];

				for (int k = 0; k < j; ++k) {
					localObject2 = (value_t) localPDVector3.get(k);
					PDUTF8String localPDUTF8String3 = ((value_t) localObject2)
							.utf8val();
					String str2 = localPDUTF8String3.getVal();
					((String[]) localObject1)[k] = str2;
				}
				localHashtable.put(str1, localObject1);
			}
		}
		return localHashtable;
	}

	private static String parseInput(String paramString) {
		String str = paramString;
		StringTokenizer localStringTokenizer = new StringTokenizer(paramString,
				" ,");

		int i = localStringTokenizer.countTokens();
		if (i > 1) {
			str = localStringTokenizer.nextToken();
			str = localStringTokenizer.nextToken();
		}
		return str;
	}

	private static byte[] getBytes(String paramString) {
		byte[] arrayOfByte = null;
		if (paramString != null) {
			try {
				arrayOfByte = paramString.getBytes("ISO8859_1");
			} catch (UnsupportedEncodingException localUnsupportedEncodingException) {
				arrayOfByte = paramString.getBytes();
			}
		}
		return arrayOfByte;
	}
}
