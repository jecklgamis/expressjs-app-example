import * as chai from 'chai';
import {default as chaiHttp} from "chai-http";

const {expect} = chai;

chai.use(chaiHttp);
const app = require('../../app');

describe('GET /probe/live', () => {
    it('should return status 200 and an object', function (done) {
        chai.request(app)
            .get('/probe/live')
            .end((err, res) => {
                if (err) return done(err);
                expect(res).to.have.status(200);
                expect(res).to.be.an('object');
                done();
            });
    });
});