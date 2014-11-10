//
// Autogenerated by Thrift Compiler (0.9.1)
//
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
//


//HELPER FUNCTIONS AND STRUCTURES

ProcessingService_payBonuses_args = function(args) {
  this.token = null;
  this.adjunction = null;
  if (args) {
    if (args.token !== undefined) {
      this.token = args.token;
    }
    if (args.adjunction !== undefined) {
      this.adjunction = args.adjunction;
    }
  }
};
ProcessingService_payBonuses_args.prototype = {};
ProcessingService_payBonuses_args.prototype.read = function(input) {
  input.readStructBegin();
  while (true)
  {
    var ret = input.readFieldBegin();
    var fname = ret.fname;
    var ftype = ret.ftype;
    var fid = ret.fid;
    if (ftype == Thrift.Type.STOP) {
      break;
    }
    switch (fid)
    {
      case 1:
      if (ftype == Thrift.Type.STRING) {
        this.token = input.readString().value;
      } else {
        input.skip(ftype);
      }
      break;
      case 2:
      if (ftype == Thrift.Type.STRUCT) {
        this.adjunction = new Adjunction();
        this.adjunction.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      default:
        input.skip(ftype);
    }
    input.readFieldEnd();
  }
  input.readStructEnd();
  return;
};

ProcessingService_payBonuses_args.prototype.write = function(output) {
  output.writeStructBegin('ProcessingService_payBonuses_args');
  if (this.token !== null && this.token !== undefined) {
    output.writeFieldBegin('token', Thrift.Type.STRING, 1);
    output.writeString(this.token);
    output.writeFieldEnd();
  }
  if (this.adjunction !== null && this.adjunction !== undefined) {
    output.writeFieldBegin('adjunction', Thrift.Type.STRUCT, 2);
    this.adjunction.write(output);
    output.writeFieldEnd();
  }
  output.writeFieldStop();
  output.writeStructEnd();
  return;
};

ProcessingService_payBonuses_result = function(args) {
  this.success = null;
  this.sessionError = null;
  this.securityError = null;
  this.validError = null;
  this.error = null;
  if (args instanceof WrongSessionException) {
    this.sessionError = args;
    return;
  }
  if (args instanceof AccessDenyException) {
    this.securityError = args;
    return;
  }
  if (args instanceof PreconditionException) {
    this.validError = args;
    return;
  }
  if (args instanceof ServerException) {
    this.error = args;
    return;
  }
  if (args) {
    if (args.success !== undefined) {
      this.success = args.success;
    }
    if (args.sessionError !== undefined) {
      this.sessionError = args.sessionError;
    }
    if (args.securityError !== undefined) {
      this.securityError = args.securityError;
    }
    if (args.validError !== undefined) {
      this.validError = args.validError;
    }
    if (args.error !== undefined) {
      this.error = args.error;
    }
  }
};
ProcessingService_payBonuses_result.prototype = {};
ProcessingService_payBonuses_result.prototype.read = function(input) {
  input.readStructBegin();
  while (true)
  {
    var ret = input.readFieldBegin();
    var fname = ret.fname;
    var ftype = ret.ftype;
    var fid = ret.fid;
    if (ftype == Thrift.Type.STOP) {
      break;
    }
    switch (fid)
    {
      case 0:
      if (ftype == Thrift.Type.STRUCT) {
        this.success = new Adjunction();
        this.success.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      case 1:
      if (ftype == Thrift.Type.STRUCT) {
        this.sessionError = new WrongSessionException();
        this.sessionError.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      case 2:
      if (ftype == Thrift.Type.STRUCT) {
        this.securityError = new AccessDenyException();
        this.securityError.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      case 3:
      if (ftype == Thrift.Type.STRUCT) {
        this.validError = new PreconditionException();
        this.validError.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      case 4:
      if (ftype == Thrift.Type.STRUCT) {
        this.error = new ServerException();
        this.error.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      default:
        input.skip(ftype);
    }
    input.readFieldEnd();
  }
  input.readStructEnd();
  return;
};

ProcessingService_payBonuses_result.prototype.write = function(output) {
  output.writeStructBegin('ProcessingService_payBonuses_result');
  if (this.success !== null && this.success !== undefined) {
    output.writeFieldBegin('success', Thrift.Type.STRUCT, 0);
    this.success.write(output);
    output.writeFieldEnd();
  }
  if (this.sessionError !== null && this.sessionError !== undefined) {
    output.writeFieldBegin('sessionError', Thrift.Type.STRUCT, 1);
    this.sessionError.write(output);
    output.writeFieldEnd();
  }
  if (this.securityError !== null && this.securityError !== undefined) {
    output.writeFieldBegin('securityError', Thrift.Type.STRUCT, 2);
    this.securityError.write(output);
    output.writeFieldEnd();
  }
  if (this.validError !== null && this.validError !== undefined) {
    output.writeFieldBegin('validError', Thrift.Type.STRUCT, 3);
    this.validError.write(output);
    output.writeFieldEnd();
  }
  if (this.error !== null && this.error !== undefined) {
    output.writeFieldBegin('error', Thrift.Type.STRUCT, 4);
    this.error.write(output);
    output.writeFieldEnd();
  }
  output.writeFieldStop();
  output.writeStructEnd();
  return;
};

ProcessingService_payBonusesByClient_args = function(args) {
  this.token = null;
  this.adjunction = null;
  if (args) {
    if (args.token !== undefined) {
      this.token = args.token;
    }
    if (args.adjunction !== undefined) {
      this.adjunction = args.adjunction;
    }
  }
};
ProcessingService_payBonusesByClient_args.prototype = {};
ProcessingService_payBonusesByClient_args.prototype.read = function(input) {
  input.readStructBegin();
  while (true)
  {
    var ret = input.readFieldBegin();
    var fname = ret.fname;
    var ftype = ret.ftype;
    var fid = ret.fid;
    if (ftype == Thrift.Type.STOP) {
      break;
    }
    switch (fid)
    {
      case 1:
      if (ftype == Thrift.Type.STRING) {
        this.token = input.readString().value;
      } else {
        input.skip(ftype);
      }
      break;
      case 2:
      if (ftype == Thrift.Type.STRUCT) {
        this.adjunction = new Adjunction();
        this.adjunction.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      default:
        input.skip(ftype);
    }
    input.readFieldEnd();
  }
  input.readStructEnd();
  return;
};

ProcessingService_payBonusesByClient_args.prototype.write = function(output) {
  output.writeStructBegin('ProcessingService_payBonusesByClient_args');
  if (this.token !== null && this.token !== undefined) {
    output.writeFieldBegin('token', Thrift.Type.STRING, 1);
    output.writeString(this.token);
    output.writeFieldEnd();
  }
  if (this.adjunction !== null && this.adjunction !== undefined) {
    output.writeFieldBegin('adjunction', Thrift.Type.STRUCT, 2);
    this.adjunction.write(output);
    output.writeFieldEnd();
  }
  output.writeFieldStop();
  output.writeStructEnd();
  return;
};

ProcessingService_payBonusesByClient_result = function(args) {
  this.success = null;
  this.sessionError = null;
  this.securityError = null;
  this.validError = null;
  this.error = null;
  if (args instanceof WrongSessionException) {
    this.sessionError = args;
    return;
  }
  if (args instanceof AccessDenyException) {
    this.securityError = args;
    return;
  }
  if (args instanceof PreconditionException) {
    this.validError = args;
    return;
  }
  if (args instanceof ServerException) {
    this.error = args;
    return;
  }
  if (args) {
    if (args.success !== undefined) {
      this.success = args.success;
    }
    if (args.sessionError !== undefined) {
      this.sessionError = args.sessionError;
    }
    if (args.securityError !== undefined) {
      this.securityError = args.securityError;
    }
    if (args.validError !== undefined) {
      this.validError = args.validError;
    }
    if (args.error !== undefined) {
      this.error = args.error;
    }
  }
};
ProcessingService_payBonusesByClient_result.prototype = {};
ProcessingService_payBonusesByClient_result.prototype.read = function(input) {
  input.readStructBegin();
  while (true)
  {
    var ret = input.readFieldBegin();
    var fname = ret.fname;
    var ftype = ret.ftype;
    var fid = ret.fid;
    if (ftype == Thrift.Type.STOP) {
      break;
    }
    switch (fid)
    {
      case 0:
      if (ftype == Thrift.Type.STRUCT) {
        this.success = new Adjunction();
        this.success.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      case 1:
      if (ftype == Thrift.Type.STRUCT) {
        this.sessionError = new WrongSessionException();
        this.sessionError.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      case 2:
      if (ftype == Thrift.Type.STRUCT) {
        this.securityError = new AccessDenyException();
        this.securityError.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      case 3:
      if (ftype == Thrift.Type.STRUCT) {
        this.validError = new PreconditionException();
        this.validError.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      case 4:
      if (ftype == Thrift.Type.STRUCT) {
        this.error = new ServerException();
        this.error.read(input);
      } else {
        input.skip(ftype);
      }
      break;
      default:
        input.skip(ftype);
    }
    input.readFieldEnd();
  }
  input.readStructEnd();
  return;
};

ProcessingService_payBonusesByClient_result.prototype.write = function(output) {
  output.writeStructBegin('ProcessingService_payBonusesByClient_result');
  if (this.success !== null && this.success !== undefined) {
    output.writeFieldBegin('success', Thrift.Type.STRUCT, 0);
    this.success.write(output);
    output.writeFieldEnd();
  }
  if (this.sessionError !== null && this.sessionError !== undefined) {
    output.writeFieldBegin('sessionError', Thrift.Type.STRUCT, 1);
    this.sessionError.write(output);
    output.writeFieldEnd();
  }
  if (this.securityError !== null && this.securityError !== undefined) {
    output.writeFieldBegin('securityError', Thrift.Type.STRUCT, 2);
    this.securityError.write(output);
    output.writeFieldEnd();
  }
  if (this.validError !== null && this.validError !== undefined) {
    output.writeFieldBegin('validError', Thrift.Type.STRUCT, 3);
    this.validError.write(output);
    output.writeFieldEnd();
  }
  if (this.error !== null && this.error !== undefined) {
    output.writeFieldBegin('error', Thrift.Type.STRUCT, 4);
    this.error.write(output);
    output.writeFieldEnd();
  }
  output.writeFieldStop();
  output.writeStructEnd();
  return;
};

ProcessingServiceClient = function(input, output) {
    this.input = input;
    this.output = (!output) ? input : output;
    this.seqid = 0;
};
ProcessingServiceClient.prototype = {};
ProcessingServiceClient.prototype.payBonuses = function(token, adjunction) {
  this.send_payBonuses(token, adjunction);
  return this.recv_payBonuses();
};

ProcessingServiceClient.prototype.send_payBonuses = function(token, adjunction) {
  this.output.writeMessageBegin('payBonuses', Thrift.MessageType.CALL, this.seqid);
  var args = new ProcessingService_payBonuses_args();
  args.token = token;
  args.adjunction = adjunction;
  args.write(this.output);
  this.output.writeMessageEnd();
  return this.output.getTransport().flush();
};

ProcessingServiceClient.prototype.recv_payBonuses = function() {
  var ret = this.input.readMessageBegin();
  var fname = ret.fname;
  var mtype = ret.mtype;
  var rseqid = ret.rseqid;
  if (mtype == Thrift.MessageType.EXCEPTION) {
    var x = new Thrift.TApplicationException();
    x.read(this.input);
    this.input.readMessageEnd();
    throw x;
  }
  var result = new ProcessingService_payBonuses_result();
  result.read(this.input);
  this.input.readMessageEnd();

  if (null !== result.sessionError) {
    throw result.sessionError;
  }
  if (null !== result.securityError) {
    throw result.securityError;
  }
  if (null !== result.validError) {
    throw result.validError;
  }
  if (null !== result.error) {
    throw result.error;
  }
  if (null !== result.success) {
    return result.success;
  }
  throw 'payBonuses failed: unknown result';
};
ProcessingServiceClient.prototype.payBonusesByClient = function(token, adjunction) {
  this.send_payBonusesByClient(token, adjunction);
  return this.recv_payBonusesByClient();
};

ProcessingServiceClient.prototype.send_payBonusesByClient = function(token, adjunction) {
  this.output.writeMessageBegin('payBonusesByClient', Thrift.MessageType.CALL, this.seqid);
  var args = new ProcessingService_payBonusesByClient_args();
  args.token = token;
  args.adjunction = adjunction;
  args.write(this.output);
  this.output.writeMessageEnd();
  return this.output.getTransport().flush();
};

ProcessingServiceClient.prototype.recv_payBonusesByClient = function() {
  var ret = this.input.readMessageBegin();
  var fname = ret.fname;
  var mtype = ret.mtype;
  var rseqid = ret.rseqid;
  if (mtype == Thrift.MessageType.EXCEPTION) {
    var x = new Thrift.TApplicationException();
    x.read(this.input);
    this.input.readMessageEnd();
    throw x;
  }
  var result = new ProcessingService_payBonusesByClient_result();
  result.read(this.input);
  this.input.readMessageEnd();

  if (null !== result.sessionError) {
    throw result.sessionError;
  }
  if (null !== result.securityError) {
    throw result.securityError;
  }
  if (null !== result.validError) {
    throw result.validError;
  }
  if (null !== result.error) {
    throw result.error;
  }
  if (null !== result.success) {
    return result.success;
  }
  throw 'payBonusesByClient failed: unknown result';
};
