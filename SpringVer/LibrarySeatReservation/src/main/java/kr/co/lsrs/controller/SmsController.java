package kr.co.lsrs.controller;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.co.lsrs.domain.SmsVO;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sms")
@Log4j
public class SmsController {
	
	@Value("${sms.url}")
	private String url;
	@Value("${sms.accessKey}")
	private String accessKey;
	@Value("${sms.secretKey}")
	private String secretKey;
	@Value("${sms.from}")
	private String from;
	
	private String makeSignature() throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException {
		String space = " ";					// one space
		String newLine = "\n";					// new line
		String method = "POST";					// method
		String timestamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date(System.currentTimeMillis()));			// current timestamp (epoch)
		
		String message = new StringBuilder()
			.append(method)
			.append(space)
			.append(url)
			.append(newLine)
			.append(timestamp)
			.append(newLine)
			.append(accessKey)
			.toString();

		SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
		Mac mac = Mac.getInstance("HmacSHA256");
		mac.init(signingKey);

		byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
		String encodeBase64String = Base64.encodeBase64String(rawHmac);

	  return encodeBase64String;
	}
	
	private RestTemplate rest;
	@PostMapping(value="/request", consumes="application/json;", produces= {MediaType.TEXT_PLAIN_VALUE})	
	public ResponseEntity<String> requestSMSAuthentication(@RequestBody SmsVO sms) throws UnsupportedEncodingException, InvalidKeyException, NoSuchAlgorithmException {
		
		JsonObject obj = new JsonObject();
		obj.addProperty("type", "SMS");
		obj.addProperty("contentType", "COMM");
		obj.addProperty("contentCode", "82");
		obj.addProperty("from", from);
		obj.addProperty("content", "테스트입니다.");
		
		JsonArray msg = new JsonArray();
		msg.add(sms.getPhNum());
		obj.add("messages", msg);
		
		String signature = makeSignature();
		log.info(signature);
		
		return new ResponseEntity<>("success", HttpStatus.OK);
	}
}
