package com.jafa.validation;

import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.jafa.domain.MemberDTO;

public class MemberDTOValidator implements Validator {

	// 검증 대상의 객체 타입 정의
	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	// 검증 작업 수행
		@Override
		public void validate(Object target, Errors errors) {
			MemberDTO dto = (MemberDTO) target;

			// 이름
			if(dto.getMemberName() == null || dto.getMemberName().isBlank()) { // 이름을 입력하지 않았을 때
				errors.rejectValue("memberName", "required.name");
			} else { // 값이 있는 경우
				String memberName = dto.getMemberName();
				if(memberName.length() < 2 || memberName.length() > 6) { // 이름은 2~6
					errors.rejectValue("memberName", "length.name");
				} else if(!Pattern.matches("^[가-힣|a-z|A-Z]*$", memberName)) {
					errors.rejectValue("memberName", "nameChar.name");
				}
			}

			// 아이디
			if(dto.getMemberId() == null || dto.getMemberId().isBlank()) {
				errors.rejectValue("memberId", "required.memberId");
			} else {
				// 4~16자, 영문 또는 숫자만 허용 ^[a-z|A-z|0-9]*$
				String memberId = dto.getMemberId();
				if(!Pattern.matches("^[a-z|A-z|0-9]*$", memberId)) {
					errors.rejectValue("memberId", "memberIdChar.id");
				} else if(memberId.length() < 4 || memberId.length() > 16) {
					errors.rejectValue("memberId", "length.memberId");
				}
			}

			// 비밀번호
			if(dto.getPassword() == null || dto.getPassword().isBlank()) { // 비밀번호를 입력하지 않았을 때
				errors.rejectValue("password", "required.password");
			} else {
				// 4~16자, 영문 또는 숫자만 허용 ^[a-z|A-z|0-9]*$
				String password = dto.getPassword();
				if(!Pattern.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,16}$", password)) {
					errors.rejectValue("password", "limit.password");
				} else if(!password.equals(dto.getConfirmPassword())) {
					errors.rejectValue("confirmPassword", "notMatching.password");
					// 비밀번호와 비밀번호 확인이 일치하지 않을 경우
				}
			}
			
			// 이메일
			if(dto.getEmail() == null || dto.getEmail().isBlank()) { // 이메일을 입력하지 않았을 때
				errors.rejectValue("email", "required.email");
			} else {
				// ^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$
				String email = dto.getEmail();
				if(!Pattern.matches("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$", email)) {
					errors.rejectValue("email", "correct.email");
				}
			}
			
			// 휴대폰번호
			if(dto.getPhoneNumber() == null || dto.getPhoneNumber().isBlank()) { // 휴대폰번호를 입력하지 않았을 때
				errors.rejectValue("phoneNumber", "required.phoneNumber");
			} else {
				//^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$
				String phoneNumber = dto.getPhoneNumber();
				if(!Pattern.matches("^(010[1-9][0-9]{6,7})$", phoneNumber)) {
					errors.rejectValue("phoneNumber", "correct.phoneNumber");
				}
			}
		}

}
