package kr.or.inair.aiimitresult.dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IAIIMITResultDaoImpl implements IAIIMITResultDao {
	@Autowired
	private SqlMapClient client;

}
