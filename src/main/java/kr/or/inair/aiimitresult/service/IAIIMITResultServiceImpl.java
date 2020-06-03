package kr.or.inair.aiimitresult.service;
import kr.or.inair.aiimitresult.dao.IAIIMITResultDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IAIIMITResultServiceImpl implements IAIIMITResultService {
	@Autowired
	private IAIIMITResultDao aiIMITResultDao;

}
